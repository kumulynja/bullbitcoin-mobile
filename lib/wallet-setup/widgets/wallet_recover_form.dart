import 'package:bb_arch/_pkg/wallet/models/wallet.dart';
import 'package:bb_arch/_ui/atoms/bb_button.dart';
import 'package:flutter/material.dart';

class WalletRecoverForm extends StatefulWidget {
  const WalletRecoverForm(
      {super.key, required this.onSubmit, this.asyncValidateSeedPhrase});

  final Function({
    required String seedPhrase,
    required String passphrase,
    required String walletName,
    required WalletType assetName,
  })? onSubmit;

  final Future<String?> Function(String)? asyncValidateSeedPhrase;

  @override
  WalletRecoverFormState createState() => WalletRecoverFormState();
}

class WalletRecoverFormState extends State<WalletRecoverForm> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _seedPhraseController = TextEditingController();
  final TextEditingController _passphraseController = TextEditingController();
  final TextEditingController _walletNameController = TextEditingController();
  WalletType _selectedAsset = WalletType.Bitcoin;

  String? _seedPhraseError;
  bool _isLoading = false;

  void _handleSubmit(BuildContext context) async {
    setState(() {
      _isLoading = true;
      _seedPhraseError = '';
    });

    if (_formKey.currentState!.validate() &&
        _syncValidateSeedPhrase(_seedPhraseController.text)) {
      if (widget.asyncValidateSeedPhrase != null) {
        final errMsg =
            await widget.asyncValidateSeedPhrase!(_seedPhraseController.text);
        if (errMsg != null) {
          setState(() {
            _seedPhraseError = errMsg;
          });
        } else {
          setState(() {
            _seedPhraseError = null;
          });

          callOnSubmit();
        }
      } else {
        callOnSubmit();
      }
    }

    setState(() {
      _isLoading = false;
    });
  }

  void callOnSubmit() {
    if (widget.onSubmit != null) {
      widget.onSubmit!(
        seedPhrase: _seedPhraseController.text,
        passphrase: _passphraseController.text,
        walletName: _walletNameController.text,
        assetName: _selectedAsset,
      );
    }
  }

  bool _syncValidateSeedPhrase(String? value) {
    if (value == null || value.isEmpty) {
      setState(() {
        _seedPhraseError = 'Please enter seed phrase';
      });
      return false;
    }
    final splits = value.split(' ');
    if (!(splits.length == 12 || splits.length == 24)) {
      setState(() {
        _seedPhraseError = 'Please enter 12 or 24 words';
      });
      return false;
    }
    return true;
  }

  @override
  void dispose() {
    _seedPhraseController.dispose();
    _passphraseController.dispose();
    _walletNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            enabled: !_isLoading,
            controller: _seedPhraseController,
            minLines: 3,
            maxLines: 4,
            decoration: InputDecoration(
              labelText: 'Seed phrase',
              border: const OutlineInputBorder(),
              errorText: _seedPhraseError,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            enabled: !_isLoading,
            controller: _passphraseController,
            decoration: const InputDecoration(
              labelText: 'Passphrase',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          TextFormField(
            enabled: !_isLoading,
            controller: _walletNameController,
            decoration: const InputDecoration(
              labelText: 'Wallet name',
              border: OutlineInputBorder(),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Please enter wallet name';
              }
              return null;
            },
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Expanded(
                child: ListTile(
                  enabled: !_isLoading,
                  title: const Text('Bitcoin'),
                  leading: Radio<WalletType>(
                    value: WalletType.Bitcoin,
                    groupValue: _selectedAsset,
                    onChanged: _isLoading
                        ? null
                        : (value) {
                            setState(() {
                              _selectedAsset = value!;
                            });
                          },
                  ),
                  onTap: () {
                    setState(() {
                      _selectedAsset = WalletType.Bitcoin;
                    });
                  },
                ),
              ),
              Expanded(
                child: ListTile(
                  enabled: !_isLoading,
                  title: const Text('Liquid'),
                  leading: Radio<WalletType>(
                    value: WalletType.Liquid,
                    groupValue: _selectedAsset,
                    onChanged: _isLoading
                        ? null
                        : (value) {
                            setState(() {
                              _selectedAsset = value!;
                            });
                          },
                  ),
                  onTap: () {
                    setState(() {
                      _selectedAsset = WalletType.Liquid;
                    });
                  },
                ),
              ),
            ],
          ),
          const SizedBox(
            height: 10,
          ),
          BBButton(
            label: 'Recover',
            isLoading: _isLoading,
            onSubmit: _handleSubmit,
          )
        ],
      ),
    );
  }
}
