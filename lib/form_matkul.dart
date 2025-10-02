import 'package:flutter/material.dart';

class FormMatkulPage extends StatefulWidget {
  const FormMatkulPage({super.key});

  @override
  State<FormMatkulPage> createState() => _FormMatkulPageState();
}

class _FormMatkulPageState extends State<FormMatkulPage> {
  final _formKey = GlobalKey<FormState>();
  int _currentStep = 0;

  final cKode = TextEditingController();
  final cNama = TextEditingController();
  final cSks = TextEditingController();
  // String? semester;
  // String? dosen;

  @override
  void dispose() {
    cKode.dispose();
    cNama.dispose();
    cSks.dispose();
    super.dispose();
  }

  void _simpan() {
    if (!_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Periksa kembali inputan Anda.")),
      );
      return;
    }
    // if (semester == null || dosen == null) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text("Lengkapi pilihan semester & dosen.")),
    //   );
    //   return;
    // }

    final data = {
      "Kode Mata Kuliah": cKode.text.trim(),
      "Nama Mata Kuliah": cNama.text.trim(),
      "SKS": cSks.text.trim(),
      // "Semester": semester,
      // "Dosen Pengampu": dosen,
    };

    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        title: const Text("Ringkasan Data Matkul"),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: data.entries
                .map((e) => Padding(
                      padding: const EdgeInsets.only(bottom: 6),
                      child: Text("${e.key}: ${e.value}"),
                    ))
                .toList(),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text("Tutup"),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final steps = [
      Step(
        title: const Text("Data Mata Kuliah"),
        isActive: true,
        state: StepState.indexed,
        content: Column(
          children: [
            TextFormField(
              controller: cKode,
              decoration: const InputDecoration(
                labelText: "Kode Mata Kuliah",
                hintText: "contoh: SI123",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.code),
              ),
              validator: (v) =>
                  v == null || v.isEmpty ? "Kode matkul wajib diisi" : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: cNama,
              decoration: const InputDecoration(
                labelText: "Nama Mata Kuliah",
                hintText: "contoh: Pemrograman Peerangkat Bergerak",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.book),
              ),
              validator: (v) =>
                  v == null || v.isEmpty ? "Nama matkul wajib diisi" : null,
            ),
            const SizedBox(height: 10),
            TextFormField(
              controller: cSks,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: "Jumlah SKS",
                hintText: "contoh: 3",
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.format_list_numbered),
              ),
              validator: (v) {
                if (v == null || v.isEmpty) {return "SKS wajib diisi";}
                if (int.tryParse(v) == null) { return "SKS harus berupa angka";}
                return null;
              },
            ),
            // const SizedBox(height: 10),
            // DropdownButtonFormField<String>(
            //   value: semester,
            //   decoration: const InputDecoration(
            //     labelText: "Semester",
            //     border: OutlineInputBorder(),
            //     prefixIcon: Icon(Icons.timeline),
            //   ),
            //   items: List.generate(
            //     8,
            //     (i) => DropdownMenuItem(
            //       value: "${i + 1}",
            //       child: Text("Semester ${i + 1}"),
            //     ),
            //   ),
            //   onChanged: (v) => setState(() => semester = v),
            //   validator: (v) => v == null ? "Pilih semester" : null,
            // ),
            // const SizedBox(height: 10),
            // DropdownButtonFormField<String>(
            //   value: dosen,
            //   decoration: const InputDecoration(
            //     labelText: "Dosen Pengampu",
            //     border: OutlineInputBorder(),
            //     prefixIcon: Icon(Icons.person),
            //   ),
            //   items: const [
            //     DropdownMenuItem(value: "Pak. Kamal", child: Text("Pak. Kamal")),
            //     DropdownMenuItem(value: "Pak. Billy", child: Text("Pak. Billy")),
            //     DropdownMenuItem(value: "Ibu. Intan", child: Text("Ibu. Intan")),
            //   ],
            //   onChanged: (v) => setState(() => dosen = v),
            //   validator: (v) => v == null ? "Pilih dosen pengampu" : null,
            // ),
          ],
        ),
      ),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Form Mata Kuliah')),
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
