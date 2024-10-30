import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart'; // Para exibir a barra de progresso circular

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Dashboards e Relatórios'),
        centerTitle: true,
        backgroundColor: Colors.grey[300],
        automaticallyImplyLeading: true, // Mostra o botão "voltar"
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título "Resumo diário"
            const Text(
              'Resumo diário',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 24, 108, 80),
              ),
            ),
            const SizedBox(height: 10),

            // Placeholder para o resumo diário (substitua com widgets gráficos reais)
            Container(
              height: 120,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Center(
                child: Icon(Icons.insert_chart, size: 50, color: Colors.grey),
              ),
            ),
            const SizedBox(height: 20),

            // Título "Próximas consultas"
            const Text(
              'Próximas consultas',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 24, 108, 80),
              ),
            ),
            const SizedBox(height: 10),

            // Lista das próximas consultas
            Expanded(
              child: ListView(
                children: const [
                  ConsultationCard(
                    doctorInitial: 'K',
                    doctorName: 'Dr. Kaue Oliver',
                    time: '14:30 - 15:00',
                  ),
                  ConsultationCard(
                    doctorInitial: 'L',
                    doctorName: 'Dra. Louise Isis',
                    time: '14:45 - 15:15',
                  ),
                  ConsultationCard(
                    doctorInitial: 'A',
                    doctorName: 'Dr. Arthur Tiago',
                    time: '15:00 - 15:45',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Consultas concluídas com barra de progresso
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Consultas concluídas:',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 24, 108, 80),
                  ),
                ),
                CircularPercentIndicator(
                  radius: 45.0,
                  lineWidth: 10.0,
                  percent: 0.8, // 80% de progresso
                  center: const Text(
                    '80%',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 24, 108, 80),
                    ),
                  ),
                  progressColor: const Color.fromARGB(255, 24, 108, 80),
                ),
              ],
            ),
            const SizedBox(height: 10),
            const Text(
              '16 de 20 consultas finalizadas',
              style: TextStyle(fontSize: 16, color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }
}

// Widget que representa uma "consulta" na lista
class ConsultationCard extends StatelessWidget {
  final String doctorInitial;
  final String doctorName;
  final String time;

  const ConsultationCard({
    Key? key,
    required this.doctorInitial,
    required this.doctorName,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: ListTile(
          contentPadding: const EdgeInsets.all(8.0),
          leading: CircleAvatar(
            backgroundColor: const Color.fromARGB(255, 24, 108, 80),
            child: Text(
              doctorInitial,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: Text(
            doctorName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(time),
          trailing: const Icon(Icons.more_vert, color: Colors.grey),
        ),
      ),
    );
  }
}
