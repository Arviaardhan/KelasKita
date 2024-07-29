import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'pembukuan_controller.dart';
import 'pembukuan_view.dart';

class ProgramKelasView extends StatelessWidget {
  final TextEditingController namaController = TextEditingController();
  final TextEditingController targetPengeluaranController = TextEditingController(text: '');
  final TextEditingController jadwalController = TextEditingController();
  final TextEditingController ketentuanController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final PembukuanKasController controller = Get.find<PembukuanKasController>();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Container(
            margin: EdgeInsets.only(left: 3.0),
            padding: EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: Color.fromARGB(255, 56, 122, 223),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Icon(Icons.arrow_back_ios_new, color: Colors.white),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Tambah Program',
          style: GoogleFonts.manrope(
            textStyle: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 25),
            Container(
              height: 1.0,
              margin: EdgeInsets.symmetric(horizontal: 25.0),
              color: Colors.grey,
            ),
            SizedBox(height: 20),
            _buildTextField(
              controller: namaController,
              label: 'Nama Program',
              hint: 'Nama Program',
            ),
            SizedBox(height: 25),
            _buildTextField(
              controller: targetPengeluaranController,
              label: 'Target Pengeluaran',
              hint: 'Target Pengeluaran',
              prefixText: 'Rp ',
            ),
            SizedBox(height: 25),
            _buildDatePickerField(
              controller: jadwalController,
              label: 'Jadwal Program',
              hint: 'Pilih Jadwal Program',
            ),
            SizedBox(height: 25),
            _buildTextField(
              controller: ketentuanController,
              label: 'Ketentuan Program',
              hint: 'Ketentuan Program',
            ),
            SizedBox(height: 30),
            Container(
              width: 350,
              height: 46,
              decoration: BoxDecoration(
                color: Color.fromARGB(255, 56, 122, 223),
                borderRadius: BorderRadius.circular(5),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: TextButton(
                onPressed: () async {
                  try {
                    final nama = namaController.text;
                    final targetPengeluaran = targetPengeluaranController.text;
                    final jadwal = DateTime.parse(jadwalController.text);
                    final ketentuan = ketentuanController.text;

                    final status = 'A';

                    await controller.postProgramKelas(
                      '4',
                      nama,
                      status,
                      targetPengeluaran,
                      jadwal,
                      DateTime.now(),
                      DateTime.now(),
                    );

                    Get.off(() => PembukuanView());
                  } catch (e) {
                    print('Error parsing date or posting data: $e');
                  }
                },
                child: Text(
                  'Unggah Program Kelas',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    String? prefixText,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: Text(
            label,
            style: GoogleFonts.manrope(
              textStyle: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        Container(
          width: 350,
          height: 46,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              color: Color(0xFF757575),
            ),
          ),
          child: Row(
            children: [
              if (prefixText != null) ...[
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    prefixText,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                ),
                VerticalDivider(
                  width: 1,
                  color: Colors.grey,
                ),
              ],
              Expanded(
                child: TextFormField(
                  controller: controller,
                  style: TextStyle(color: Colors.black),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12),
                    hintText: hint,
                    hintStyle: TextStyle(
                      fontSize: 16,
                      color: Colors.black.withOpacity(0.20),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDatePickerField({
    required TextEditingController controller,
    required String label,
    required String hint,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 25.0),
          child: Text(
            label,
            style: GoogleFonts.manrope(
              textStyle: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                color: Colors.black,
              ),
            ),
          ),
        ),
        SizedBox(height: 10),
        GestureDetector(
          onTap: () async {
            DateTime? selectedDate = await showDatePicker(
              context: Get.context!,
              initialDate: DateTime.now(),
              firstDate: DateTime(2000),
              lastDate: DateTime(2101),
              builder: (BuildContext context, Widget? child) {
                return Theme(
                  data: ThemeData.light().copyWith(
                    primaryColor: Color.fromARGB(255, 56, 122, 223),
                    colorScheme: ColorScheme.light(
                      primary: Color.fromARGB(255, 56, 122, 223),
                    ),
                    buttonTheme: ButtonThemeData(
                      textTheme: ButtonTextTheme.primary,
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (selectedDate != null) {
              controller.text = selectedDate.toLocal().toString().split(' ')[0];
            }
          },
          child: AbsorbPointer(
            child: Container(
              width: 350,
              height: 46,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(5),
                border: Border.all(
                  color: Color(0xFF757575),
                ),
              ),
              child: TextFormField(
                controller: controller,
                style: TextStyle(color: Colors.black),
                decoration: InputDecoration(
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.symmetric(horizontal: 12),
                  hintText: hint,
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.20),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
