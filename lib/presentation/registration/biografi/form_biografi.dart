import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kelas_kita/presentation/registration/biografi/biografi_controller.dart';
import 'package:kelas_kita/presentation/screens/pending/pending_view.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:kelas_kita/routes/app_routes.dart';

import 'kelas_model.dart';


class BiografiView extends StatelessWidget {
  BiografiView({Key? key}) : super(key: key);

  final BiografiController biografiController = Get.put(BiografiController());

  // final GoogleSignInAccount user;

  Future<void> _getImageFromGallery() async {
    final imagePicker = ImagePicker();
    final pickedFile = await imagePicker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      final File image = File(pickedFile.path);
      biografiController.selectedImagePath.value = image;
    }
  }

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    double imageWidth = screenWidth * 0.4;

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Stack(
              children: [
                Container(
                  width: screenWidth,
                  height: screenHeight * 0.20,
                  color: Color.fromARGB(255, 56, 122, 223),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    margin: EdgeInsets.only(left: screenWidth * 0.13),
                    child: Image.asset(
                      'lib/assets/images/lr_form.png',
                      fit: BoxFit.fill,
                      width: imageWidth,
                      height: screenHeight * 0.2,
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(
                      left: screenWidth * 0.54, top: screenHeight * 0.07),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Isi form dengan',
                        style: TextStyle(
                          fontFamily: 'tsSubHeader5',
                          fontWeight: FontWeight.w500,
                          fontSize: screenWidth * 0.0490,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.003),
                      Text(
                        'data kalian',
                        style: TextStyle(
                          fontFamily: 'tsSubHeader5',
                          fontWeight: FontWeight.w500,
                          fontSize: screenWidth * 0.0490,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(
                screenWidth * 0.05,
                screenWidth * 0.03,
                screenWidth * 0.05,
                screenHeight * 0.0,
              ),
              child: FractionallySizedBox(
                widthFactor: 0.99,
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: Colors.black.withOpacity(0.2),
                      width: 1,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(screenWidth * 0.05),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildFormField(
                          controller: biografiController.namaController,
                          label: 'Nama',
                          hint: 'Nama',
                          hintDescription: 'Isi dengan nama asli',
                          screenWidth: screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.025),
                        Container(
                          height: screenHeight * 0.16,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Icon(Icons.school),
                                  SizedBox(width: screenWidth * 0.015,),
                                  Text('Kelas', style: TextStyle(
                                    fontFamily: 'tsParagraft3',
                                    fontWeight: FontWeight.w500,
                                    fontSize: screenWidth * 0.04,
                                  )),
                                ],
                              ),
                              FutureBuilder(
                                future: biografiController.fetchKelas(),
                                builder: (context, snapshot) {
                                  if (snapshot.connectionState == ConnectionState.waiting) {
                                    return Container(
                                      padding: EdgeInsets.only(left: 10, right: 10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black.withOpacity(0.4),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      child: DropdownButtonFormField<String?>(
                                        dropdownColor: Colors.white,
                                        value: biografiController.selectedKelas.value.nama.isNotEmpty ? biografiController.selectedKelas.value.nama : null,
                                        items: biografiController.kelasList.map((KelasModel kelas) {
                                          return DropdownMenuItem<String>(
                                            value: kelas.idKelas.toString(),
                                            child: Text(kelas.nama),
                                          );
                                        }).toList(),
                                        onChanged: (String? value) {
                                          if (value != null) {
                                            print('Selected value: $value');
                                            biografiController.idKelas.value = value;
                                          }
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Pilih Kelas',
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    );
                                  } else {
                                    print('List of classes: ${biografiController.kelasList}');
                                    return Container(
                                      padding: EdgeInsets.only(left: 10, right: 10),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.black.withOpacity(0.4),
                                          width: 1.5,
                                        ),
                                        borderRadius: BorderRadius.circular(5.0),
                                      ),
                                      child: DropdownButtonFormField<String?>(
                                        dropdownColor: Colors.white,
                                        value: biografiController.selectedKelas.value.nama.isNotEmpty ? biografiController.selectedKelas.value.nama : null,
                                        items: biografiController.kelasList.map((KelasModel kelas) {
                                          return DropdownMenuItem<String>(
                                            value: kelas.idKelas.toString(),
                                            child: Text(kelas.nama),
                                          );
                                        }).toList(),
                                        onChanged: (String? value) {
                                          if (value != null) {
                                            print('Selected value: $value');
                                            biografiController.idKelas.value = value;
                                          }
                                        },
                                        decoration: InputDecoration(
                                          hintText: 'Pilih Kelas',
                                          border: InputBorder.none,
                                        ),
                                      ),
                                    );
                                  }
                                },
                              ),
                              Text("Isi sesuai kelas", style: TextStyle(
                                fontFamily: 'tsParagraft4',
                                fontWeight: FontWeight.w500,
                                fontSize: screenWidth * 0.0325,
                                color: Colors.black.withOpacity(0.4),
                              )),
                            ],
                          ),
                        ),
                        SizedBox(height: screenHeight * 0.025),
                        buildFormField(
                          controller: biografiController.nisController,
                          label: 'NIS',
                          hint: 'NIS',
                          hintDescription: 'Isi dengan NIS Anda',
                          screenWidth: screenWidth,
                          textInputType: TextInputType.number,
                          inputFormatter: FilteringTextInputFormatter.digitsOnly,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'NIS tidak boleh kosong';
                            }
                            if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
                              return 'Masukkan NIS yang valid';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: screenHeight * 0.025),
                        buildFormField(
                          controller: biografiController.alamatController,
                          label: 'Alamat',
                          hint: 'Alamat',
                          hintDescription: 'Isi dengan alamat Anda',
                          screenWidth: screenWidth,
                        ),
                        SizedBox(height: screenHeight * 0.05),
                        Column(
                          children: [
                            GestureDetector(
                              onTap: _getImageFromGallery,
                              child: Obx(() => Container(
                                  margin: EdgeInsets.symmetric(
                                      vertical: screenHeight * 0.01),
                                  height: screenHeight * 0.2,
                                  decoration: BoxDecoration(
                                    color: biografiController.selectedImagePath.value !=
                                        null
                                        ? Colors.grey.shade200
                                        : Colors.grey.shade200,
                                    borderRadius: BorderRadius.circular(5),
                                    image: biografiController.selectedImagePath.value !=
                                        null
                                        ? DecorationImage(
                                      image: FileImage(
                                          biografiController.selectedImagePath
                                              .value!),
                                      fit: BoxFit.cover,
                                    )
                                        : null,
                                  ),
                                  child: biografiController.selectedImagePath.value ==
                                      null
                                      ? Container(
                                    margin: EdgeInsets.all(15),
                                    child: SvgPicture.asset(
                                        "lib/assets/icons/pe_camera.svg"),
                                  )
                                      : null,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            Text('Isi dengan foto anda atau ID Card anda', style: TextStyle(
                              fontFamily: 'tsParagraft3',
                              fontWeight: FontWeight.bold,
                              fontSize: screenWidth * 0.0375,
                              color: Colors.black.withOpacity(0.5),
                            ),)
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.fromLTRB(
          screenWidth * 0.06,
          screenHeight * 0.025,
          screenWidth * 0.06,
          screenHeight * 0.050,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            buildButton(
              text: 'Back',
              color: Colors.white,
              textColor: Colors.red,
              borderColor: Colors.red,
              screenWidth: screenWidth,
              onTap: () {
                Get.toNamed('/loginView');
              },
            ),
            buildButton(
              text: 'Submit',
              color: Color.fromARGB(255, 56, 122, 223),
              textColor: Colors.white,
              screenWidth: screenWidth,
              onTap: () async {
                SharedPreferences prefs = await SharedPreferences.getInstance();
                String imagePath = biografiController.selectedImagePath.value?.path ?? '';
                String userId = (await SharedPreferences.getInstance()).getInt('id_user').toString();

                await biografiController.submitBiografi(
                  biografiController.namaController.text,
                  biografiController.idKelas.value,
                  biografiController.nisController.text,
                  biografiController.alamatController.text,
                  userId,
                  imagePath,
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildFormField({
    TextEditingController? controller,
    required String label,
    required String hint,
    required String hintDescription,
    required double screenWidth,
    TextInputType? textInputType,
    TextInputFormatter? inputFormatter,
    void Function(String)? onChanged,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.person, size: screenWidth * 0.05),
            SizedBox(width: screenWidth * 0.0125),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'tsParagraft3',
                fontWeight: FontWeight.w500,
                fontSize: screenWidth * 0.04,
              ),
            ),
          ],
        ),
        SizedBox(height: screenWidth * 0.0125),
        Container(
          width: double.infinity,
          height: screenWidth * 0.1,
          child: TextFormField(
            onChanged: onChanged,
            validator: validator,
            controller: controller,
            keyboardType: label == "NIS"
                ? TextInputType.phone
                : TextInputType.text,
            inputFormatters: label == "NIS"
                ? <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ] : null,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: TextStyle(
                fontFamily: 'tsParagraft3',
                fontWeight: FontWeight.w500,
                fontSize: screenWidth * 0.0375,
                color: Colors.black.withOpacity(0.2),
              ),
              contentPadding: EdgeInsets.fromLTRB(
                screenWidth * 0.03,
                screenWidth * 0.05,
                screenWidth * 0.03,
                screenWidth * 0.02,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.4),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.5),
                  width: 2.0,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black.withOpacity(0.2),
                  width: 2.0,
                ),
              ),
            ),
          ),
        ),
        SizedBox(height: screenWidth * 0.0125),
        Text(
          hintDescription,
          style: TextStyle(
            fontFamily: 'tsParagraft3',
            fontWeight: FontWeight.w500,
            fontSize: screenWidth * 0.0325,
            color: Colors.black.withOpacity(0.4),
          ),
        ),
      ],
    );
  }

  Widget buildButton({
    required String text,
    required Color color,
    required Color textColor,
    double? screenWidth,
    Color? borderColor,
    VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: screenWidth! * 0.35,
        height: screenWidth * 0.1,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(5),
          border: borderColor != null
              ? Border.all(color: borderColor, width: 2)
              : null,
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: screenWidth * 0.04,
              fontWeight: FontWeight.bold,
              fontFamily: 'tsParagraft3',
            ),
          ),
        ),
      ),
    );
  }
}
