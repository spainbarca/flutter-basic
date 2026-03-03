import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Onboarding - Service Desk',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF0066CC),
          primary: const Color(0xFF0066CC),
        ),
        useMaterial3: true,
      ),
      home: const OnboardingScreen(),
    );
  }
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  // Estados para las pestañas de días
  int selectedDayTab = 0; // 0: Día 1, 1: Días 2-3, 2: Día 4-5
  
  // Estado para la navegación inferior
  int selectedBottomNav = 0; // 0: Lista, 1: Contacto, 2: Progreso
  
  // Estados para las tareas del Día 1
  List<Map<String, dynamic>> day1Tasks = [
    {
      'title': 'Correo',
      'status': 'En curso',
      'description': 'Configurar tu email corporativo para día: TI',
      'hasDropdown': false,
      'isSelected': false,
      'originalStatus': 'En curso',
    },
    {
      'title': 'Laptop',
      'status': 'Listo',
      'description': 'Recoger laptop y configurarla',
      'hasDropdown': true,
      'isSelected': true,
      'originalStatus': 'Listo',
    },
    {
      'title': 'Accesos',
      'status': 'Pendiente',
      'description': 'Activar permisos / VPN / sistemas',
      'hasDropdown': false,
      'isSelected': false,
      'originalStatus': 'Pendiente',
    },
    {
      'title': 'Equipo CRM',
      'status': 'Pendiente',
      'description': 'Acceso a la herramienta CRM',
      'hasDropdown': true,
      'isSelected': false,
      'originalStatus': 'Pendiente',
    },
  ];

  // Datos de ejemplo para Días 2-3 y Día 4-5
  final List<Map<String, dynamic>> day23Tasks = [
    {
      'title': 'Capacitación',
      'status': 'Pendiente',
      'description': 'Curso básico de Service Desk',
      'isSelected': false,
    },
    {
      'title': 'Documentación',
      'status': 'Pendiente',
      'description': 'Revisar manuales y procedimientos',
      'isSelected': false,
    },
  ];

  final List<Map<String, dynamic>> day45Tasks = [
    {
      'title': 'Prácticas',
      'status': 'Pendiente',
      'description': 'Simulaciones con equipo senior',
      'isSelected': false,
    },
    {
      'title': 'Evaluación',
      'status': 'Pendiente',
      'description': 'Prueba de conocimientos básicos',
      'isSelected': false,
    },
  ];

  // Datos de contacto
  final List<Map<String, dynamic>> contacts = [
    {
      'name': 'Carlos Mendoza',
      'role': 'Jefatura TI',
      'department': 'Jefatura',
      'email': 'carlos.mendoza@empresa.com',
      'phone': '+51 987 654 321',
      'avatar': 'CM',
      'color': Colors.blue,
    },
    {
      'name': 'Ana Torres',
      'role': 'Especialista Senior',
      'department': 'Soporte',
      'email': 'ana.torres@empresa.com',
      'phone': '+51 987 654 322',
      'avatar': 'AT',
      'color': Colors.green,
    },
    {
      'name': 'Roberto Sánchez',
      'role': 'Administrador de Redes',
      'department': 'Infraestructura',
      'email': 'roberto.sanchez@empresa.com',
      'phone': '+51 987 654 323',
      'avatar': 'RS',
      'color': Colors.orange,
    },
    {
      'name': 'María López',
      'role': 'Gerente de TI',
      'department': 'Gerencia TI',
      'email': 'maria.lopez@empresa.com',
      'phone': '+51 987 654 324',
      'avatar': 'ML',
      'color': Colors.purple,
    },
  ];

  void _toggleDay1TaskSelection(int index) {
    setState(() {
      day1Tasks[index]['isSelected'] = !day1Tasks[index]['isSelected'];
      
      if (day1Tasks[index]['isSelected']) {
        day1Tasks[index]['status'] = 'Completado';
      } else {
        day1Tasks[index]['status'] = day1Tasks[index]['originalStatus'];
      }
    });
  }

  void _toggleTaskSelectionGeneric(List<Map<String, dynamic>> taskList, int index) {
    setState(() {
      taskList[index]['isSelected'] = !taskList[index]['isSelected'];
      
      if (taskList[index]['isSelected']) {
        taskList[index]['status'] = 'Completado';
      } else {
        taskList[index]['status'] = 'Pendiente';
      }
    });
  }

  void _selectDayTab(int index) {
    setState(() {
      selectedDayTab = index;
    });
  }

  void _selectBottomNav(int index) {
    setState(() {
      selectedBottomNav = index;
    });
  }

  // Calcular progreso total
  double getProgressPercentage() {
    int totalTasks = day1Tasks.length + day23Tasks.length + day45Tasks.length;
    int completedTasks = 0;
    
    for (var task in day1Tasks) {
      if (task['isSelected']) completedTasks++;
    }
    
    for (var task in day23Tasks) {
      if (task['isSelected']) completedTasks++;
    }
    
    for (var task in day45Tasks) {
      if (task['isSelected']) completedTasks++;
    }
    
    return totalTasks > 0 ? completedTasks / totalTasks : 0.0;
  }

 @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
      title: const Text(
        'Hola, Anabel',
        style: TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      backgroundColor: const Color(0xFF0066CC),
      foregroundColor: Colors.white,
      actions: [
        IconButton(
          icon: const Icon(Icons.person),
          onPressed: () {},
        ),
      ],
    ),
    body: _buildCurrentScreen(),
    bottomNavigationBar: _BottomNavBar(
      selectedIndex: selectedBottomNav,
      onTap: _selectBottomNav,
    ),
  );
}

  Widget _buildCurrentScreen() {
    switch (selectedBottomNav) {
      case 0:
        return _buildListScreen();
      case 1:
        return _buildContactScreen();
      case 2:
        return _buildProgressScreen();
      default:
        return _buildListScreen();
    }
  }

  Widget _buildListScreen() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Título
            Text(
              'Onboarding - Analista Service Desk',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: Colors.grey[700],
              ),
            ),
            const SizedBox(height: 8),
            
            // Subtítulo
            const Text(
              'Semana 1: Completa estos pasos y avanza rápido.',
              style: TextStyle(
                fontSize: 16,
                color: Color(0xFF0066CC),
              ),
            ),
            const SizedBox(height: 32),
            
            // Pestañas de días (clickeables)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildDayTab('Día 1', 0),
                _buildDayTab('Días 2-3', 1),
                _buildDayTab('Día 4-5', 2),
              ],
            ),
            const SizedBox(height: 32),
            
            // Sección Agenda
            const Text(
              'Agenda',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            // Contenido según la pestaña seleccionada
            _buildDayContent(),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildContactScreen() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Contactos del Equipo',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0066CC),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Personas clave para tu onboarding',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),
            
            // Lista de contactos
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: contacts.length,
              separatorBuilder: (context, index) => const SizedBox(height: 16),
              itemBuilder: (context, index) {
                final contact = contacts[index];
                return Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: contact['color'],
                      child: Text(
                        contact['avatar'],
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    title: Text(
                      contact['name'],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 4),
                        Text(
                          contact['role'],
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                          decoration: BoxDecoration(
                            color: contact['color'].withOpacity(0.1),
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            contact['department'],
                            style: TextStyle(
                              color: contact['color'],
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            const Icon(Icons.email, size: 16, color: Colors.grey),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                contact['email'],
                                style: const TextStyle(fontSize: 14),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          children: [
                            const Icon(Icons.phone, size: 16, color: Colors.grey),
                            const SizedBox(width: 8),
                            Text(
                              contact['phone'],
                              style: const TextStyle(fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.message, color: Color(0xFF0066CC)),
                      onPressed: () {
                        // Acción para enviar mensaje
                      },
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressScreen() {
    double progress = getProgressPercentage();
    int totalTasks = day1Tasks.length + day23Tasks.length + day45Tasks.length;
    int completedTasks = (progress * totalTasks).round();
    
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Mi Progreso',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF0066CC),
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Seguimiento de tu onboarding',
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 32),
            
            // Tarjeta de progreso general
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Progreso General',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          '${(progress * 100).toStringAsFixed(1)}%',
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0066CC),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    // Barra de progreso
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.grey[200],
                      color: const Color(0xFF0066CC),
                      minHeight: 12,
                      borderRadius: BorderRadius.circular(6),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '$completedTasks de $totalTasks tareas completadas',
                      style: const TextStyle(color: Colors.grey),
                    ),
                    const SizedBox(height: 24),
                    
                    // Gráfico lineal simple
                    Container(
                      height: 200,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            const Text(
                              'Evolución del Progreso',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(height: 16),
                            Expanded(
                              child: _buildLineChart(progress),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),
            
            // Detalle por día
            const Text(
              'Progreso por Día',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            
            Column(
              children: [
                _buildDayProgressCard('Día 1', day1Tasks),
                const SizedBox(height: 12),
                _buildDayProgressCard('Días 2-3', day23Tasks),
                const SizedBox(height: 12),
                _buildDayProgressCard('Día 4-5', day45Tasks),
              ],
            ),
            
            // Consejo motivacional
            const SizedBox(height: 32),
            Card(
              color: const Color(0xFF0066CC).withOpacity(0.1),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    const Icon(Icons.lightbulb, color: Color(0xFF0066CC)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Consejo del día',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF0066CC),
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            progress > 0.7 
                              ? '¡Excelente trabajo! Ya casi terminas tu onboarding.'
                              : progress > 0.3
                                ? 'Vas por buen camino. Sigue completando las tareas.'
                                : 'Comienza por las tareas más importantes para avanzar rápidamente.',
                            style: const TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLineChart(double progress) {
    // Datos de ejemplo para el gráfico (simulando progreso diario)
    List<double> dailyProgress = [
      0.0,
      progress * 0.25,
      progress * 0.5,
      progress * 0.75,
      progress
    ];
    
    double maxValue = dailyProgress.reduce((a, b) => a > b ? a : b);
    maxValue = maxValue > 0 ? maxValue : 1.0;
    
    return CustomPaint(
      size: const Size(double.infinity, 150),
      painter: _LineChartPainter(dailyProgress: dailyProgress, maxValue: maxValue),
    );
  }

  Widget _buildDayProgressCard(String day, List<Map<String, dynamic>> tasks) {
    int completed = tasks.where((task) => task['isSelected']).length;
    int total = tasks.length;
    double progress = total > 0 ? completed / total : 0.0;
    
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  day,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Text(
                  '${(progress * 100).toStringAsFixed(0)}%',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: progress > 0.5 ? Colors.green : Colors.orange,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[200],
              color: progress > 0.5 ? Colors.green : Colors.orange,
              minHeight: 8,
              borderRadius: BorderRadius.circular(4),
            ),
            const SizedBox(height: 8),
            Text(
              '$completed de $total tareas completadas',
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDayTab(String text, int index) {
    bool isActive = selectedDayTab == index;
    return GestureDetector(
      onTap: () => _selectDayTab(index),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF0066CC) : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color(0xFF0066CC),
            width: 2,
          ),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: isActive ? Colors.white : const Color(0xFF0066CC),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildDayContent() {
    switch (selectedDayTab) {
      case 0:
        return _buildDay1Content();
      case 1:
        return _buildDay23Content();
      case 2:
        return _buildDay45Content();
      default:
        return _buildDay1Content();
    }
  }

  Widget _buildDay1Content() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ExpansionTile(
        title: const Row(
          children: [
            Icon(
              Icons.arrow_drop_down,
              color: Color(0xFF0066CC),
            ),
            SizedBox(width: 8),
            Text(
              'Día 1',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF0066CC),
              ),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: day1Tasks.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> task = entry.value;
                return _TaskItem(
                  title: task['title'],
                  status: task['status'],
                  description: task['description'],
                  hasDropdown: task['hasDropdown'],
                  isSelected: task['isSelected'],
                  onTap: () => _toggleDay1TaskSelection(index),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDay23Content() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ExpansionTile(
        title: const Row(
          children: [
            Icon(
              Icons.arrow_drop_down,
              color: Color(0xFF0066CC),
            ),
            SizedBox(width: 8),
            Text(
              'Días 2-3',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF0066CC),
              ),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: day23Tasks.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> task = entry.value;
                return _TaskItem(
                  title: task['title'],
                  status: task['status'],
                  description: task['description'],
                  hasDropdown: false,
                  isSelected: task['isSelected'],
                  onTap: () => _toggleTaskSelectionGeneric(day23Tasks, index),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDay45Content() {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(8),
      ),
      child: ExpansionTile(
        title: const Row(
          children: [
            Icon(
              Icons.arrow_drop_down,
              color: Color(0xFF0066CC),
            ),
            SizedBox(width: 8),
            Text(
              'Día 4-5',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Color(0xFF0066CC),
              ),
            ),
          ],
        ),
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              children: day45Tasks.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> task = entry.value;
                return _TaskItem(
                  title: task['title'],
                  status: task['status'],
                  description: task['description'],
                  hasDropdown: false,
                  isSelected: task['isSelected'],
                  onTap: () => _toggleTaskSelectionGeneric(day45Tasks, index),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _TaskItem extends StatelessWidget {
  final String title;
  final String status;
  final String description;
  final bool hasDropdown;
  final bool isSelected;
  final VoidCallback onTap;

  const _TaskItem({
    required this.title,
    required this.status,
    required this.description,
    this.hasDropdown = false,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    Color statusColor;
    
    switch (status.toLowerCase()) {
      case 'completado':
      case 'listo':
        statusColor = Colors.green;
        break;
      case 'en curso':
        statusColor = Colors.orange;
        break;
      default: // pendiente
        statusColor = Colors.grey;
    }

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: isSelected ? const Color(0xFF0066CC) : Colors.transparent,
            width: 2,
          ),
          color: isSelected ? const Color(0xFF0066CC).withOpacity(0.1) : Colors.transparent,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Checkbox visual
            Container(
              width: 24,
              height: 24,
              margin: const EdgeInsets.only(right: 12),
              decoration: BoxDecoration(
                color: isSelected ? Colors.green : Colors.transparent,
                border: Border.all(
                  color: isSelected ? Colors.green : Colors.grey[400]!,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(4),
              ),
              child: isSelected
                  ? const Icon(
                      Icons.check,
                      size: 16,
                      color: Colors.white,
                    )
                  : null,
            ),
            
            // Contenido de la tarea
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isSelected ? const Color(0xFF0066CC) : Colors.black,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          status,
                          style: TextStyle(
                            color: statusColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: TextStyle(
                      color: isSelected ? const Color(0xFF0066CC) : Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
            
            // Flecha dropdown si es necesario
            if (hasDropdown)
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Icon(
                  Icons.arrow_drop_down,
                  color: Colors.grey,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

class _LineChartPainter extends CustomPainter {
  final List<double> dailyProgress;
  final double maxValue;

  _LineChartPainter({required this.dailyProgress, required this.maxValue});

  @override
  void paint(Canvas canvas, Size size) {
    final paintLine = Paint()
      ..color = const Color(0xFF0066CC)
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final paintFill = Paint()
      ..color = const Color(0xFF0066CC).withOpacity(0.2)
      ..style = PaintingStyle.fill;

    final paintPoint = Paint()
      ..color = const Color(0xFF0066CC)
      ..style = PaintingStyle.fill;

    final paintGrid = Paint()
      ..color = Colors.grey[300]!
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;

    // Dibujar líneas de la cuadrícula
    for (int i = 0; i <= 5; i++) {
      final y = size.height - (i / 5) * size.height;
      canvas.drawLine(
        Offset(0, y),
        Offset(size.width, y),
        paintGrid,
      );
    }

    // Calcular puntos
    final List<Offset> points = [];
    for (int i = 0; i < dailyProgress.length; i++) {
      final x = (i / (dailyProgress.length - 1)) * size.width;
      final y = size.height - (dailyProgress[i] / maxValue) * size.height;
      points.add(Offset(x, y));
    }

    // Dibujar área bajo la línea
    final pathFill = Path();
    if (points.isNotEmpty) {
      pathFill.moveTo(points.first.dx, size.height);
      for (var point in points) {
        pathFill.lineTo(point.dx, point.dy);
      }
      pathFill.lineTo(points.last.dx, size.height);
      pathFill.close();
      canvas.drawPath(pathFill, paintFill);
    }

    // Dibujar línea
    final pathLine = Path();
    if (points.isNotEmpty) {
      pathLine.moveTo(points.first.dx, points.first.dy);
      for (int i = 1; i < points.length; i++) {
        pathLine.lineTo(points[i].dx, points[i].dy);
      }
      canvas.drawPath(pathLine, paintLine);
    }

    // Dibujar puntos
    for (var point in points) {
      canvas.drawCircle(point, 5, paintPoint);
      canvas.drawCircle(point, 3, Paint()..color = Colors.white);
    }

    // Dibujar etiquetas
    final textPainter = TextPainter(
      textDirection: TextDirection.ltr,
    );

    for (int i = 0; i < dailyProgress.length; i++) {
      final text = 'D${i + 1}';
      textPainter.text = TextSpan(
        text: text,
        style: const TextStyle(color: Colors.grey, fontSize: 12),
      );
      textPainter.layout();
      textPainter.paint(
        canvas,
        Offset(points[i].dx - textPainter.width / 2, size.height + 5),
      );
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

// Bottom Navigation Bar
class _BottomNavBar extends StatelessWidget {
  final int selectedIndex;
  final Function(int) onTap;

  const _BottomNavBar({
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _buildBottomNavItem(Icons.list, 'Lista', 0),
          _buildBottomNavItem(Icons.contacts, 'Contacto', 1),
          _buildBottomNavItem(Icons.timeline, 'Progreso', 2),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label, int index) {
    bool isActive = selectedIndex == index;
    return GestureDetector(
      onTap: () => onTap(index),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: isActive ? const Color(0xFF0066CC) : Colors.grey[200],
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: isActive ? Colors.white : Colors.grey[600],
            ),
          ),
          const SizedBox(height: 4),
          Text(
            label,
            style: TextStyle(
              color: isActive ? const Color(0xFF0066CC) : Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}