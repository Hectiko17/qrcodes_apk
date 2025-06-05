import 'package:flutter/material.dart';

void main() {
  runApp(const InventarioApp());
}

class InventarioApp extends StatelessWidget {
  const InventarioApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inventario QR',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool mostrarInventario = false;

  final List<Map<String, String>> inventario = [
    {
      "Código": "P001",
      "Nombre": "Taladro Bosch",
      "Categoría": "Herramienta",
      "Cantidad": "10"
    },
    {
      "Código": "P002",
      "Nombre": "Tornillo M4x20",
      "Categoría": "Tornillería",
      "Cantidad": "500"
    },
    {
      "Código": "P003",
      "Nombre": "Cable UTP",
      "Categoría": "Electrónica",
      "Cantidad": "50"
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Inventario QR'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                setState(() {
                  mostrarInventario = !mostrarInventario;
                });
              },
              child: const Text("Mostrar Inventario"),
            ),
            const SizedBox(height: 20),
            if (mostrarInventario)
              Expanded(
                child: ListView.builder(
                  itemCount: inventario.length,
                  itemBuilder: (context, index) {
                    final item = inventario[index];
                    return Card(
                      child: ListTile(
                        title: Text(item['Nombre']!),
                        subtitle: Text(
                            "Código: ${item['Código']}\nCategoría: ${item['Categoría']}\nCantidad: ${item['Cantidad']}"),
                      ),
                    );
                  },
                ),
              )
          ],
        ),
      ),
    );
  }
}
