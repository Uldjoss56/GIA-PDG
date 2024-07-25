import 'package:audioplayers/audioplayers.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gia_pdg_partenaire/components/show_info.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';
import 'package:gia_pdg_partenaire/services/const.dart';
import 'package:gia_pdg_partenaire/services/product_service.dart';
import 'package:gia_pdg_partenaire/components/custom_clipper.dart';
import 'package:gia_pdg_partenaire/components/scan_show_dialog.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class DMAAuthentification extends ConsumerStatefulWidget {
  const DMAAuthentification({
    super.key,
  });

  @override
  ConsumerState<DMAAuthentification> createState() =>
      _DMAAuthentificationState();
}

class _DMAAuthentificationState extends ConsumerState<DMAAuthentification> {
  Barcode? result;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  bool isLoading = false;
  bool isScanning = true;

  final _productService = ProductService();

  double _height = 0, _width = 0;

  bool hasFoundCode = false;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    _width = width;
    _height = height;
    return Scaffold(
      backgroundColor: myPink,
      body: Column(
        children: [
          Expanded(
            child: Stack(
              children: [
                Stack(
                  children: [
                    _buildQrView(context),
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
                                "assets/img/background02.png",
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: myPink02,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  SizedBox(
                                    width: 0.3 * width,
                                    child: Text(
                                      isLoading
                                          ? "authentification"
                                          : "scanning ",
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        overflow: TextOverflow.ellipsis,
                                        color: myPink01,
                                        fontFamily: "Manrope",
                                        fontWeight: FontWeight.w600,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ),
                                  if (isScanning || isLoading)
                                    const Row(
                                      children: [
                                        SizedBox(
                                          height: 15,
                                          width: 15,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: myPink01,
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
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

  Widget _buildQrView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 150.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: myPink,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
      isScanning = true;
    });
    controller.scannedDataStream.listen((scanData) async {
      if (!hasFoundCode) {
        setState(() {
          result = scanData;
          isScanning = false;
          isLoading = true;
        });
        hasFoundCode = true;
        await checkProductAuth(result?.code ?? "0");
      }
    });
  }

  _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    if (!p) {
      messenger(
        context,
        "Accès à la caméra refusé",
      );
    }
  }

  Future<void> playLocalAudio() async {
    final AudioPlayer audioPlayer = AudioPlayer();

    final Source audioSource = AssetSource('audios/cloche.wav');

    audioPlayer.play(audioSource);
  }

  Future<void> playEndAudio() async {
    final AudioPlayer audioPlayer = AudioPlayer();

    final Source audioSource = AssetSource('audios/win.wav');

    audioPlayer.play(audioSource);
  }

  checkProductAuth(String code) async {
    final internetConnexion = await checkUserConnexion();
    if (internetConnexion) {
      setState(() {
        isLoading = true;
      });
      try {
        final response = await _productService.authProduct(code);
        final product = response.product;

        if (response.message!.contains("Produit authentique")) {
          await playLocalAudio();
          showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            builder: (context) {
              return ScanShowDialog(
                height: _height,
                width: _width,
                isAuthentificate: product!.isActived == "1" ? true : false,
                product: product,
              );
            },
          );
        } else {
          await playLocalAudio();
          // ignore: use_build_context_synchronously
          showDialog(
            // ignore: use_build_context_synchronously
            context: context,
            builder: (context) {
              return ScanShowDialog(
                height: _height,
                width: _width,
                isAuthentificate: null,
              );
            },
          );
        }
        setState(() {
          hasFoundCode = false;
          isScanning = true;
        });
      } on DioException catch (e) {
        // ignore: use_build_context_synchronously
        messenger(context, e.response!.data["message"]);
        setState(() {
          isScanning = true;
          hasFoundCode = false;
        });
      } finally {
        setState(() {
          isLoading = false;
          isScanning = true;
          hasFoundCode = false;
        });
      }
    } else {
      // ignore: use_build_context_synchronously
      messenger(context, "Connectez-vous à internet");
    }
  }
}
