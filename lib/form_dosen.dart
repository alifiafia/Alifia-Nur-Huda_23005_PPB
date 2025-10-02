import 'package:flutter/material.dart';

class FormDosenPage extends StatefulWidget {
  const FormDosenPage({super.key});

  @override
  State<FormDosenPage> createState() => _FormDosenPageState();
}

class _FormDosenPageState extends State<FormDosenPage> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;

  // controller untuk inputan
  final cNidn = TextEditingController();
  final cNama = TextEditingController();
  final cHomebase = TextEditingController();
  final cEmail = TextEditingController();
  final cTelepon = TextEditingController();

  @override
  void dispose() {
    cNidn.dispose();
    cNama.dispose();
    cHomebase.dispose();
    cEmail.dispose();
    cTelepon.dispose();
    super.dispose();
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Periksa kembali isian Anda.')),
      );
      return;
    }

    final data = {
      'NIDN': cNidn.text.trim(),
      'Nama': cNama.text.trim(),
      'Home Base': cHomebase.text.trim(),
      'Email': cEmail.text.trim(),
      'Telepon': cTelepon.text.trim(),
    };

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text('Ringkasan Data Dosen'),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: data.entries
                .map(
                  (e) => Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Text('${e.key}: ${e.value}'),
                  ),
                )
                .toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Tutup'),
          ),
        ],
      ),
    );
  }

  Widget _sectionTitle(String text) => Padding(
    padding: const EdgeInsets.only(bottom: 8, top: 8),
    child: Text(
      text,
      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    ),
  );

  @override
  Widget build(BuildContext context) {
    final steps = <Step>[
      Step(
        title: const Text('Data Dosen'),
        isActive: true,
        state: StepState.indexed,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _sectionTitle('Identitas Dosen'),
            TextFormField(
              controller: cNidn,
              decoration: const InputDecoration(
                labelText: 'NIDN',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.badge),
              ),
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return 'NIDN wajib diisi';
                }
                if (int.tryParse(v) == null) {
                  return 'NIDN harus berupa angka';
                }
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: cNama,
              decoration: const InputDecoration(
                labelText: 'Nama Lengkap',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.person),
              ),
              validator: (v) =>
                  (v == null || v.isEmpty) ? 'Nama wajib diisi' : null,
            ),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: const InputDecoration(
                labelText: 'Home Base',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.home_work),
              ),
              items: const [
                DropdownMenuItem(
                  value: 'TI',
                  child: Text('Teknik Informatika'),
                ),
                DropdownMenuItem(value: 'SI', child: Text('Sistem Informasi')),
              ],
              onChanged: (value) {
                cHomebase.text = value ?? '';
              },
              validator: (v) =>
                  (v == null || v.isEmpty) ? 'Homebase wajib diisi' : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: cEmail,
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.email),
              ),
              validator: (v) =>
                  (v == null || v.isEmpty) ? 'Email wajib diisi' : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: cTelepon,
              decoration: const InputDecoration(
                labelText: 'No. Telepon',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.phone),
              ),
              validator: (v) {
                if (v == null || v.isEmpty) {
                  return 'Telepon wajib diisi';
                }
                if (int.tryParse(v) == null) {
                  return 'Telepon harus berupa angka';
                }
                return null;
              },
            ),
          ],
        ),
      ),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Form Dosen')),
      body: Form(
        key: _formKey,
        child: Stepper(
          type: StepperType.vertical,
          currentStep: _currentStep,
          steps: steps,
          onStepContinue: _simpan,
          onStepCancel: null,
          controlsBuilder: (context, details) {
            return Padding(
              padding: const EdgeInsets.only(top: 20), // kasih jarak atas
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.save),
                      label: const Text('Simpan'),
                      onPressed: details.onStepContinue,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
