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
      floatingActionButton: mostrarInventario
          ? FloatingActionButton(
              onPressed: () => _mostrarFormulario(context),
              child: const Icon(Icons.add),
            )
          : null,
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

  void _mostrarFormulario(BuildContext context) {
    final codigoController = TextEditingController();
    final nombreController = TextEditingController();
    final categoriaController = TextEditingController();
    final cantidadController = TextEditingController();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Agregar nuevo producto'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: codigoController,
                  decoration: const InputDecoration(labelText: 'Código'),
                ),
                TextField(
                  controller: nombreController,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                ),
                TextField(
                  controller: categoriaController,
                  decoration: const InputDecoration(labelText: 'Categoría'),
                ),
                TextField(
                  controller: cantidadController,
                  decoration: const InputDecoration(labelText: 'Cantidad'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  inventario.add({
                    "Código": codigoController.text,
                    "Nombre": nombreController.text,
                    "Categoría": categoriaController.text,
                    "Cantidad": cantidadController.text,
                  });
                });
                Navigator.of(context).pop();
              },
              child: const Text('Guardar'),
            ),
          ],
        );
      },
    );
  }
}
