import 'package:flutter/material.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/widget/custom_clipper.dart';
import 'package:gia_pdg_partenaire/ui/pdg_ui/widget/scan_show_dialog.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class DMAAuthentification extends StatefulWidget {
  const DMAAuthentification({super.key});

  @override
  State<DMAAuthentification> createState() => _DMAAuthentificationState();
}

class _DMAAuthentificationState extends State<DMAAuthentification> {
  final _qrKey = GlobalKey(debugLabel: "QR");
  QRViewController? _controller;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: myPink,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Stack(
                  children: [
                    QRView(
                      key: _qrKey,
                      onQRViewCreated: _onQRViewCreated,
                    ),
                    Container(
                      height: 0.9 * height,
                      width: width,
                      color: myPink55,
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                    top: 40,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: IconButton(
                      style: IconButton.styleFrom(
                        elevation: 5,
                        backgroundColor: myPink55,
                        foregroundColor: myWhite,
                      ),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.keyboard_arrow_left_rounded,
                        size: 30,
                        weight: 30,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ClipPath(
                    clipper: ContainerClipper02(),
                    child: Stack(
                      children: [
                        Container(
                          height: 0.3 * height,
                          padding: EdgeInsets.symmetric(
                            horizontal: 0.2 * width,
                            vertical: 0.11 * height,
                          ),
                          decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/img/background02.jpg",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: InkWell(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) {
                                  return ScanShowDialog(
                                    height: height,
                                    width: width,
                                    isAuthentificate: true,
                                  );
                                },
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: myWhite,
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: const Center(
                                child: Text(
                                  "scanning",
                                  style: TextStyle(
                                    color: myPink,
                                    fontFamily: "Manrope",
                                    fontWeight: FontWeight.w600,
                                    fontSize: 18,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      _controller = controller;
    });
    _controller!.scannedDataStream.listen((scanData) {
      showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            title: Text("QR Code Scanned"),
          );
        },
      );
    });
  }
}
