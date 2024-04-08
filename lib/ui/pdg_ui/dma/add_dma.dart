import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';
import 'package:gia_pdg_partenaire/models/other_models.dart';
import 'package:gia_pdg_partenaire/provider/other_provider.dart';

class AddDMA extends ConsumerStatefulWidget {
  const AddDMA({super.key});

  @override
  ConsumerState<AddDMA> createState() => _AddDMAState();
}

class _AddDMAState extends ConsumerState<AddDMA> {
  Device? selectedDevice;

  List<Device> devicesList = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    devicesList = ref.watch(devicesProvider);
    selectedDevice = devicesList[0];
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: myPink,
      appBar: AppBar(
        backgroundColor: myPink,
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Center(
            child: Icon(
              Icons.keyboard_arrow_left_rounded,
              color: myWhite,
              size: 30,
              weight: 30,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Center(
              child: CircleAvatar(
                backgroundColor: myPink01,
                radius: 0.3 * width,
                child: ColorFiltered(
                  colorFilter: const ColorFilter.mode(
                    myWhite,
                    BlendMode.srcIn,
                  ),
                  child: Image.asset(
                    "assets/img/icons/qr-code_white.png",
                    width: 0.2 * width,
                    height: 0.2 * width,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 0.06 * height,
            ),
            Container(
              padding: const EdgeInsets.all(20),
              margin: const EdgeInsets.all(20),
              decoration: const BoxDecoration(
                gradient: RadialGradient(
                  colors: [
                    myWhite,
                    myPink02,
                  ],
                ),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Form(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Nom",
                      style: TextStyle(
                        fontFamily: "Manrope",
                        color: myGrisFonce,
                      ),
                    ),
                    TextField(
                      maxLength: 20,
                      decoration: InputDecoration(
                        hintText: "nom du DMA",
                        hintStyle: const TextStyle(
                          fontFamily: "Manrope",
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 0,
                          ),
                          child: CircleAvatar(
                            radius: 10,
                            child: ColorFiltered(
                              colorFilter: const ColorFilter.mode(
                                myGrisFonceAA,
                                BlendMode.srcIn,
                              ),
                              child: Image.asset(
                                "assets/img/icons/product_name.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: myPink),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: myGrisFonce55,
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      "Équipement associé *",
                      style: TextStyle(
                        fontFamily: "Manrope",
                        color: myGrisFonce,
                      ),
                    ),
                    DropdownButtonFormField(
                      value: devicesList[0],
                      decoration: InputDecoration(
                        prefixIcon: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 0,
                          ),
                          child: CircleAvatar(
                            radius: 10,
                            child: ColorFiltered(
                              colorFilter: const ColorFilter.mode(
                                myGrisFonceAA,
                                BlendMode.srcIn,
                              ),
                              child: Image.asset(
                                "assets/img/icons/link.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        focusedBorder: const OutlineInputBorder(
                          borderSide: BorderSide(color: myPink),
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        enabledBorder: const OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          borderSide: BorderSide(
                            color: myGrisFonce55,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 15,
                          vertical: 10,
                        ),
                      ),
                      style: const TextStyle(
                        color: myGrisFonceAA,
                      ),
                      items: List.generate(
                        devicesList.length,
                        (index) => DropdownMenuItem(
                          value: devicesList[index],
                          child: Text(devicesList[index].name ?? ""),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          selectedDevice = value;
                        });
                      },
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        const Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Expire le : ",
                              style: TextStyle(
                                fontFamily: "Manrope",
                                color: myGrisFonce,
                              ),
                            ),
                            Text(
                              "20-02-2026",
                              style: TextStyle(
                                fontFamily: "Manrope",
                                color: myGrisFonce,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          child: Row(
                            children: [
                              Expanded(
                                child: Container(
                                  decoration: BoxDecoration(
                                    gradient: const RadialGradient(
                                      radius: 1.5,
                                      colors: [
                                        myPink,
                                        myPink01,
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      foregroundColor: Colors.transparent,
                                      elevation: 0,
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 15,
                                      ),
                                      shape: ContinuousRectangleBorder(
                                        borderRadius: BorderRadius.circular(40),
                                      ),
                                    ),
                                    onPressed: () {},
                                    child: const Text(
                                      "Valider",
                                      style: TextStyle(
                                        fontFamily: "Manrope",
                                        fontWeight: FontWeight.w900,
                                        fontSize: 18,
                                        color: myWhite,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
