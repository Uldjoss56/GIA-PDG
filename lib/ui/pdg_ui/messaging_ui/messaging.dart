import 'package:dio/dio.dart';
import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gia_pdg_partenaire/components/const/number.dart';
import 'package:gia_pdg_partenaire/components/custom_clipper.dart';
import 'package:gia_pdg_partenaire/components/show_info.dart';
import 'package:gia_pdg_partenaire/const/colors.dart';
import 'package:gia_pdg_partenaire/datas/datas.dart';
import 'package:gia_pdg_partenaire/models/user.dart';
import 'package:gia_pdg_partenaire/models/user_message.dart';
import 'package:gia_pdg_partenaire/provider/message.dart';
import 'package:gia_pdg_partenaire/provider/user_provider.dart';
import 'package:gia_pdg_partenaire/services/const.dart';
import 'package:gia_pdg_partenaire/services/message_service.dart';
import 'package:gia_pdg_partenaire/services/users_service.dart';

class MessagingUI extends ConsumerStatefulWidget {
  const MessagingUI({
    super.key,
    required this.roleID,
  });
  final int roleID;

  @override
  ConsumerState<MessagingUI> createState() => _MessagingUIState();
}

class _MessagingUIState extends ConsumerState<MessagingUI> {
  User? _currentUser;
  UserMessages? _userMessages;

  bool isLoading = false;

  final _messageService = MessageService();

  final _messageController = TextEditingController();

  final _userService = UserService();

  User? _destinataire;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _currentUser = ref.watch(userProvider);
    loadDestinataire();
  }

  @override
  Widget build(BuildContext context) {
    _userMessages = ref.watch(
        userMessagesProvider)["${_currentUser?.id}_${_destinataire?.id}"];
    final messages = _userMessages?.messages ?? [];
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          widget.roleID == 2 ? "Distributeur Officiel" : "Administrateur",
          style: const TextStyle(
            color: myPink,
            fontFamily: "Manrope",
            fontWeight: FontWeight.w800,
          ),
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Center(
            child: Icon(
              Icons.keyboard_arrow_left_rounded,
              color: myPink,
              size: 30,
              weight: 30,
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          (messages.isEmpty && isLoading)
              ? const Expanded(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Expanded(
                  child: SingleChildScrollView(
                    reverse: true,
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: List.generate(messages.length, (index) {
                          final message = messages[index];
                          return Column(
                            children: [
                              if (index == 0)
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 1,
                                        color: myGrisFonce55,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        dateFormatD.format(messages[index !=
                                                            messages.length - 1
                                                        ? index + 1
                                                        : index]
                                                    .updatedAt!) ==
                                                dateFormatD.format(
                                                  DateTime.now(),
                                                )
                                            ? "aujourd'hui"
                                            : dateFormatD.format(messages[index !=
                                                                messages.length -
                                                                    1
                                                            ? index + 1
                                                            : index]
                                                        .updatedAt!) ==
                                                    dateFormatD.format(
                                                        DateTime.now().subtract(
                                                      const Duration(
                                                        days: 1,
                                                      ),
                                                    ))
                                                ? "hier"
                                                : dateOtherFormat(
                                                    message.updatedAt ??
                                                        DateTime.now(),
                                                  ),
                                        style: const TextStyle(
                                          fontFamily: "Manrope",
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 1,
                                        color: myGrisFonce55,
                                      ),
                                    ),
                                  ],
                                ),
                              if (message.idReceiver == _currentUser!.id)
                                Align(
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                      bottom: 10,
                                      right: 100,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        ClipPath(
                                          clipper: ContainerClipper01(),
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                              left: 25,
                                              top: 10,
                                              bottom: 12,
                                              right: 10,
                                            ),
                                            decoration: const BoxDecoration(
                                              color: myPink,
                                            ),
                                            child: ExpandableText(
                                              message.text ?? "",
                                              style: const TextStyle(
                                                fontFamily: "Manrope",
                                                color: myWhite,
                                              ),
                                              expandText: "voir plus",
                                              collapseText: " réduire",
                                              maxLines: 4,
                                              linkStyle: const TextStyle(
                                                fontFamily: "Manrope",
                                                color: myGrisFonceAA,
                                              ),
                                            ),
                                          ),
                                        ),
                                        /*
                                        Text(
                                          "${_destinataire!.name!.split(" ")[0]}, ${dateFormatH.format(
                                            message.updatedAt ?? DateTime.now(),
                                          )}",
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontFamily: "Manrope",
                                            color: myGrisFonceAA,
                                            fontWeight: FontWeight.w600,
                                            fontSize: 10,
                                          ),
                                        ),
                                        */
                                      ],
                                    ),
                                  ),
                                )
                              else
                                Align(
                                  alignment: Alignment.centerRight,
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                      top: 10,
                                      bottom: 10,
                                      left: 100,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        ClipPath(
                                          clipper: ContainerClipper(),
                                          child: Container(
                                            padding: const EdgeInsets.only(
                                              left: 12,
                                              top: 12,
                                              bottom: 10,
                                              right: 20,
                                            ),
                                            decoration: const BoxDecoration(
                                              color: Colors.blue,
                                            ),
                                            child: ExpandableText(
                                              message.text ?? "",
                                              style: const TextStyle(
                                                fontFamily: "Manrope",
                                                color: myWhite,
                                              ),
                                              expandText: "voir plus",
                                              collapseText: " réduire",
                                              maxLines: 4,
                                              linkStyle: const TextStyle(
                                                fontFamily: "Manrope",
                                                color: myGrisFonceAA,
                                              ),
                                            ),

                                            /*
                                            Text(
                                              message.text ?? "",
                                              softWrap: true,
                                              maxLines: 6,
                                              overflow: TextOverflow.ellipsis,
                                              style: const TextStyle(
                                                fontFamily: "Manrope",
                                                color: myWhite,
                                                overflow: TextOverflow.ellipsis,
                                                //fontSize:  16,
                                                fontWeight: FontWeight.w500,
                                              ),
                                            ),
                                            */
                                          ),
                                        ),
                                        /*
                                        Text(
                                          "vous, ${dateFormatH.format(
                                            message.updatedAt ?? DateTime.now(),
                                          )}",
                                          overflow: TextOverflow.ellipsis,
                                          style: const TextStyle(
                                            fontFamily: "Manrope",
                                            color: myGrisFonceAA,
                                            fontWeight: FontWeight.w800,
                                            fontSize: 10,
                                          ),
                                        ),
                                        */
                                      ],
                                    ),
                                  ),
                                ),
                              if (index != 0 &&
                                  compareDates(
                                    message.updatedAt!,
                                    messages[index != messages.length - 1
                                            ? index + 1
                                            : index]
                                        .updatedAt!,
                                  ))
                                Row(
                                  children: [
                                    Expanded(
                                      child: Container(
                                        height: 1,
                                        color: myGrisFonce55,
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Text(
                                        dateFormatD.format(messages[index !=
                                                            messages.length - 1
                                                        ? index + 1
                                                        : index]
                                                    .updatedAt!) ==
                                                dateFormatD
                                                    .format(DateTime.now())
                                            ? "aujourd'hui"
                                            : dateFormatD.format(messages[index !=
                                                                messages.length -
                                                                    1
                                                            ? index + 1
                                                            : index]
                                                        .updatedAt!) ==
                                                    dateFormatD.format(
                                                        DateTime.now().subtract(
                                                      const Duration(
                                                        days: 1,
                                                      ),
                                                    ))
                                                ? "hier"
                                                : dateOtherFormat(
                                                    message.updatedAt ??
                                                        DateTime.now(),
                                                  ),
                                        style: const TextStyle(
                                          fontFamily: "Manrope",
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Container(
                                        height: 1,
                                        color: myGrisFonce55,
                                      ),
                                    ),
                                  ],
                                ),
                            ],
                          );
                        }),
                      ),
                    ),
                  ),
                ),
          Container(
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: myWhite,
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  offset: Offset(0, 0),
                  blurRadius: 1,
                  spreadRadius: 1,
                  color: myGrisFonce22,
                ),
              ],
            ),
            child: TextField(
              controller: _messageController,
              maxLines: 4,
              minLines: 1,
              decoration: InputDecoration(
                hintText: "votre message",
                hintStyle: const TextStyle(
                  fontFamily: "Manrope",
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                prefixIcon: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    // vertical: 2,
                  ),
                  child: CircleAvatar(
                    child: AspectRatio(
                      aspectRatio: 1,
                      child: ClipOval(
                        child: Image.asset(
                          userData["profilImage"],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                suffixIcon: InkWell(
                  onTap: () {
                    if (_messageController.text.isNotEmpty) {
                      sendMessages({
                        "text": _messageController.text,
                        "id_receiver": _destinataire?.id,
                      });
                    }
                    setState(() {
                      _messageController.text = "";
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      // vertical: 2,
                    ),
                    child: CircleAvatar(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: Image.asset(
                          "assets/img/icons/send.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  loadDestinataire() async {
    final internetConnexion = await checkUserConnexion();
    if (internetConnexion) {
      setState(() {
        isLoading = true;
      });
      try {
        final response = await _userService.getUsersByRole(
          {
            "role_id": widget.roleID,
          },
        );
        final users = response["users"];
        setState(() {
          _destinataire = User.fromJson((users as List)[0]);
          getAllMessages({
            "receiver_id": _destinataire?.id,
          });
        });
      } on DioException catch (e) {
        // ignore: use_build_context_synchronously
        messenger(context, e.response!.data["message"]);
        return List.empty();
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      // ignore: use_build_context_synchronously
      messenger(context, "Connectez-vous à internet");
      return List.empty();
    }
  }

  getAllMessages(Map<String, dynamic> data) async {
    final internetConnexion = await checkUserConnexion();
    if (internetConnexion) {
      setState(() {
        isLoading = true;
      });
      try {
        final response = await _messageService.getAllMessages(data);

        final userMessagesNotifier = ref.read(userMessagesProvider.notifier);
        userMessagesNotifier.updateUserMessages({
          "${_currentUser?.id}_${_destinataire?.id}": response,
        });
      } on DioException catch (e) {
        // ignore: use_build_context_synchronously
        messenger(context, e.response!.data["message"]);
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      // ignore: use_build_context_synchronously
      messenger(context, "Connectez-vous à internet");
    }
  }

  sendMessages(Map<String, dynamic> data) async {
    final internetConnexion = await checkUserConnexion();
    if (internetConnexion) {
      setState(() {
        isLoading = true;
      });
      try {
        await _messageService.sendMessage(
          data,
        );

        getAllMessages({
          "receiver_id": _destinataire?.id,
        });
      } on DioException catch (e) {
        // ignore: use_build_context_synchronously
        messenger(context, e.response!.data["message"]);
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    } else {
      // ignore: use_build_context_synchronously
      messenger(context, "Connectez-vous à internet");
    }
  }
}
