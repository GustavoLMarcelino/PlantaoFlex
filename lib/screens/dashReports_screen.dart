import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

class DashReportsScreen extends StatelessWidget {
  const DashReportsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Relatórios Financeiros'),
        backgroundColor: Colors.blueGrey,
        centerTitle: true,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('consultas').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(child: Text('Nenhuma consulta encontrada.'));
          }

          final consultas = snapshot.data!.docs;

          return FutureBuilder<List<Map<String, dynamic>>>(
            future: _calculateFinancialData(consultas),
            builder: (context, futureSnapshot) {
              if (futureSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!futureSnapshot.hasData || futureSnapshot.data!.isEmpty) {
                return const Center(child: Text('Nenhum dado financeiro disponível.'));
              }

              final financialData = futureSnapshot.data!;

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Expanded(
                      child: buildMosaicChart(financialData),
                    ),
                    const SizedBox(height: 20),
                    Expanded(
                      child: buildDetailsList(financialData),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }

  // Função para calcular os dados financeiros agrupados por médico com nomes
  Future<List<Map<String, dynamic>>> _calculateFinancialData(
      List<QueryDocumentSnapshot<Object?>> consultas) async {
    final Map<String, Map<String, dynamic>> aggregatedData = {};

    for (var consulta in consultas) {
      final data = consulta.data() as Map<String, dynamic>;
      final doctorId = data['doctorId'] ?? 'Desconhecido';
      final fee = (data['fee'] ?? 0).toDouble();

      if (aggregatedData.containsKey(doctorId)) {
        aggregatedData[doctorId]!['totalFee'] += fee;
        aggregatedData[doctorId]!['consultas'] += 1;
      } else {
        final doctorName = await _getDoctorName(doctorId);
        aggregatedData[doctorId] = {
          'doctorName': doctorName,
          'totalFee': fee,
          'consultas': 1,
        };
      }
    }

    return aggregatedData.values.toList();
  }

  // Função para buscar o nome do médico com base no doctorId
  Future<String> _getDoctorName(String doctorId) async {
    if (doctorId == 'Desconhecido') return 'Médico não encontrado';
    final docSnapshot = await FirebaseFirestore.instance
        .collection('medicos')
        .doc(doctorId)
        .get();
    if (docSnapshot.exists) {
      return docSnapshot['name'] ?? 'Nome não disponível';
    }
    return 'Médico não encontrado';
  }

  // Função para construir o gráfico de barras
  Widget buildMosaicChart(List<Map<String, dynamic>> data) {
    final barGroups = data
        .asMap()
        .entries
        .map((entry) {
          final index = entry.key;
          final doctorData = entry.value;
          return BarChartGroupData(
            x: index,
            barRods: [
              BarChartRodData(
                toY: doctorData['totalFee'],
                color: Colors.blueGrey,
                width: 16,
                borderRadius: BorderRadius.circular(4),
              ),
            ],
            showingTooltipIndicators: [0],
          );
        })
        .toList();

    return BarChart(
      BarChartData(
        gridData: FlGridData(show: false),
        borderData: FlBorderData(
          border: const Border(
            top: BorderSide.none,
            right: BorderSide.none,
            bottom: BorderSide(width: 1),
            left: BorderSide(width: 1),
          ),
        ),
        barGroups: barGroups,
        titlesData: FlTitlesData(
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 40,
              getTitlesWidget: (value, _) {
                return Text(
                  value.toInt().toString(),
                  style: const TextStyle(fontSize: 12),
                );
              },
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, _) {
                if (value.toInt() < data.length) {
                  final doctorName = data[value.toInt()]['doctorName'];
                  return Text(
                    doctorName,
                    style: const TextStyle(fontSize: 10),
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }

  // Função para construir a lista detalhada
  Widget buildDetailsList(List<Map<String, dynamic>> data) {
    return ListView.builder(
      itemCount: data.length,
      itemBuilder: (context, index) {
        final doctorData = data[index];
        return Card(
          margin: const EdgeInsets.symmetric(vertical: 8.0),
          child: ListTile(
            title: Text(doctorData['doctorName']),
            subtitle: Text(
              'Consultas: ${doctorData['consultas']} | Total: R\$${doctorData['totalFee'].toStringAsFixed(2)}',
            ),
          ),
        );
      },
    );
  }
}
