import 'dart:async';

import 'package:bb_mobile/_model/transaction.dart';
import 'package:bb_mobile/_model/wallet.dart';
import 'package:bb_mobile/_pkg/consts/keys.dart';
import 'package:bb_mobile/_ui/components/button.dart';
import 'package:bb_mobile/_ui/components/indicators.dart';
import 'package:bb_mobile/_ui/components/text.dart';
import 'package:bb_mobile/_ui/warning.dart';
import 'package:bb_mobile/currency/bloc/currency_cubit.dart';
import 'package:bb_mobile/home/bloc/home_cubit.dart';
import 'package:bb_mobile/home/transactions.dart';
import 'package:bb_mobile/network/bloc/network_cubit.dart';
import 'package:bb_mobile/settings/bloc/lighting_cubit.dart';
import 'package:bb_mobile/styles.dart';
import 'package:bb_mobile/wallet/bloc/state.dart';
import 'package:bb_mobile/wallet/bloc/wallet_bloc.dart';
import 'package:bb_mobile/wallet/wallet_card.dart';
import 'package:extra_alignments/extra_alignments.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // final homeCubit = context.read<HomeCubit>();
    // return MultiBlocProvider(
    //   providers: [
    //     BlocProvider.value(value: homeCubit),
    //   ],
    //   child: const _Screen(),
    // );
    return const _Screen();
  }
}

class _Screen extends StatefulWidget {
  const _Screen();

  @override
  State<_Screen> createState() => _ScreenState();
}

class _ScreenState extends State<_Screen> {
  int _currentPage = 0;

  void _onChanged(int page) {
    _currentPage = page;
    setState(() {});
  }

  static const double _oneCardH = 110.0;
  static const double _twoCardH = 210.0;
  static const double _threeCardH = 310.0;

  double _calculateHeight(int cardsLen) {
    if (cardsLen == 1) return _oneCardH;
    if (cardsLen == 2) return _twoCardH;
    if (cardsLen == 3) return _threeCardH;

    // final isOdd = cardsLen % 2 != 0;
    final isLastPage = _currentPage == (cardsLen / 3).floor();
    final cardsOnPage = isLastPage ? cardsLen % 3 : 3;

    if (cardsOnPage == 1) return _oneCardH;
    if (cardsOnPage == 2) return _twoCardH;
    if (cardsOnPage == 3) return _threeCardH;

    return _threeCardH;

    // return (isLastPage && isOdd) ? _oneCardH : _threeCardH;
  }

  static AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false,
      shadowColor: context.colour.primary.withOpacity(0.2),
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      flexibleSpace: const HomeTopBar2(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final _ = context.select((HomeCubit x) => x.state.walletBlocs);
    final loading = context.select((HomeCubit x) => x.state.loadingWallets);
    if (loading) return const Scaffold(body: SizedBox.shrink());

    final network = context.select((NetworkCubit x) => x.state.getBBNetwork());
    final walletBlocs = context.select((HomeCubit x) => x.state.walletBlocsFromNetwork(network));

    if (walletBlocs.isEmpty) {
      final isTestnet = network == BBNetwork.Testnet;
      if (!isTestnet) {
        scheduleMicrotask(() async {
          await Future.delayed(100.ms);
          SystemChrome.setSystemUIOverlayStyle(
            SystemUiOverlayStyle(
              statusBarColor: context.colour.primary,
            ),
          );
        });
      }
      return Scaffold(
        appBar: !isTestnet ? null : _buildAppBar(context),
        body: HomeNoWallets(fullRed: !isTestnet),
      );
    }

    final h = _calculateHeight(walletBlocs.length);

    return Scaffold(
      appBar: _buildAppBar(context),
      body: Stack(
        children: [
          TopCenter(
            child: SizedBox(
              height: 310,
              child: CardsList(
                walletBlocs: walletBlocs,
                onChanged: _onChanged,
              ),
            ).animate(delay: 300.ms).fadeIn(),
          ).animate().fadeIn(),
          Column(
            children: [
              AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                height: h,
                // height: 310,
              ),
              Expanded(
                child: ColoredBox(
                  color: context.colour.background,
                  child: const HomeTransactions(),
                ),
              ),
              const Gap(128),
            ],
          ),
          BottomCenter(
            child: Container(
              height: 128,
              margin: const EdgeInsets.only(top: 16),
              child: HomeBottomBar2(
                walletBloc: walletBlocs.length == 1 ? walletBlocs[0] : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CardsList extends StatelessWidget {
  const CardsList({super.key, required this.walletBlocs, required this.onChanged});

  final List<WalletBloc> walletBlocs;
  final Function(int) onChanged;

  static List<CardColumn> buildCardColumns(List<WalletBloc> wallets) {
    final List<CardColumn> columns = [];
    final isOne = wallets.length == 1;
    for (var i = 0; i < wallets.length; i += 3) {
      final walletTop = wallets[i];
      final walletBottom = i + 1 < wallets.length ? wallets[i + 1] : null;
      final walletLast = i + 2 < wallets.length ? wallets[i + 2] : null;

      columns.add(
        CardColumn(
          walletTop: walletTop,
          walletBottom: walletBottom,
          walletLast: walletLast,
          onlyOne: isOne,
        ),
      );
    }
    return columns;
  }

  @override
  Widget build(BuildContext context) {
    final columns = buildCardColumns(walletBlocs);

    return PageView(
      scrollDirection: Axis.vertical,
      onPageChanged: onChanged,
      children: columns,
    );
  }
}

class CardColumn extends StatelessWidget {
  const CardColumn({
    super.key,
    required this.walletTop,
    this.walletBottom,
    this.walletLast,
    this.onlyOne = false,
  });

  final WalletBloc walletTop;
  final WalletBloc? walletBottom;
  final WalletBloc? walletLast;
  final bool onlyOne;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 26,
        // vertical: 24,
      ),
      child: Column(
        children: [
          BlocProvider.value(
            value: walletTop,
            child: const CardItem(),
          ),
          // const Gap(8),
          if (walletBottom != null)
            BlocProvider.value(
              value: walletBottom!,
              child: const CardItem(),
            ),
          if (walletLast != null)
            BlocProvider.value(
              value: walletLast!,
              child: const CardItem(),
            )
          else if (!onlyOne)
            const EmptyCard(),
        ],
      ),
    );
  }
}

class EmptyCard extends StatelessWidget {
  const EmptyCard({super.key});

  @override
  Widget build(BuildContext context) {
    return const Expanded(
      child: SizedBox(
        width: double.infinity,
        child: Card(
          color: Colors.transparent,
          elevation: 0,
        ),
      ),
    );
  }
}

class CardItem extends StatelessWidget {
  const CardItem({super.key});

  @override
  Widget build(BuildContext context) {
    final wallet = context.select((WalletBloc x) => x.state.wallet);
    if (wallet == null) return const SizedBox.shrink();

    final (color, _) = WalletCardDetails.cardDetails(context, wallet);

    final name = context.select((WalletBloc x) => x.state.wallet?.name);
    final fingerprint = context.select((WalletBloc x) => x.state.wallet?.sourceFingerprint ?? '');
    final walletStr = context.select((WalletBloc x) => x.state.wallet?.getWalletTypeStr());

    final sats = context.select((WalletBloc x) => x.state.balanceSats());

    final balance =
        context.select((CurrencyCubit x) => x.state.getAmountInUnits(sats, removeText: true));
    final unit =
        context.select((CurrencyCubit x) => x.state.getUnitString(isLiquid: wallet.isLiquid()));

    final fiatCurrency = context.select((CurrencyCubit x) => x.state.defaultFiatCurrency);

    final fiatAmt = context.select((NetworkCubit x) => x.state.calculatePrice(sats, fiatCurrency));

    // return const SizedBox(
    //   height: 125,
    //   width: double.infinity,
    //   child: Card(
    //     color: Colors.amber,
    //     elevation: 2,
    //   ),
    // );

    return SizedBox(
      width: double.infinity,
      height: 100,
      child: Card(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        color: context.colour.background,
        child: DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                color.withOpacity(0.73),
                color,
              ],
            ),
          ),
          child: InkWell(
            onTap: () {
              final walletBloc = context.read<WalletBloc>();
              context.push('/wallet', extra: walletBloc);
            },
            child: Padding(
              padding: const EdgeInsets.only(
                // top: 4,
                right: 16.0,
                left: 24,
                // bottom: 4,
              ),
              child: Stack(
                children: [
                  TopRight(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 4),
                      child: IconButton(
                        onPressed: () {
                          final walletBloc = context.read<WalletBloc>();
                          context.push('/wallet-settings', extra: walletBloc);
                        },
                        color: context.colour.onPrimary,
                        icon: const FaIcon(
                          FontAwesomeIcons.ellipsis,
                        ),
                      ),
                    ),
                  ),
                  // TopLeft(
                  //   child: Padding(
                  //     padding: const EdgeInsets.only(
                  //       top: 8,
                  //     ),
                  //     child: BBText.titleLarge(
                  //       name ?? fingerprint,
                  //       onSurface: true,
                  //     ),
                  //   ),
                  // ),
                  Column(
                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Gap(8),
                      BBText.titleLarge(
                        name ?? fingerprint,
                        onSurface: true,
                        fontSize: 20,
                        compact: true,
                      ),
                      const Gap(4),

                      Opacity(
                        opacity: 0.7,
                        child: BBText.bodySmall(
                          walletStr ?? '',
                          onSurface: true,
                          isBold: true,
                          fontSize: 12,
                        ),
                      ),
                      const Spacer(),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          BBText.titleLarge(
                            balance,
                            onSurface: true,
                            isBold: true,
                            fontSize: 24,
                            compact: true,
                          ),
                          const Gap(4),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 1),
                            child: BBText.title(
                              unit,
                              onSurface: true,
                              isBold: true,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                      if (fiatCurrency != null) ...[
                        // const Gap(16),
                        Row(
                          // crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            BBText.bodySmall(
                              '~' + fiatAmt,
                              onSurface: true,
                              fontSize: 12,

                              // isBold: true,
                            ),
                            const Gap(4),
                            Padding(
                              padding: const EdgeInsets.only(bottom: 1),
                              child: BBText.bodySmall(
                                fiatCurrency.shortName.toUpperCase(),
                                onSurface: true,
                                fontSize: 12,
                                // isBold: true,
                              ),
                            ),
                          ],
                        ),
                      ],
                      const Gap(4),
                      // const Spacer(flex: 2),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class WalletTag extends StatelessWidget {
  const WalletTag({super.key, required this.wallet, required this.tx});

  final Wallet wallet;
  final Transaction tx;

  static (String, Color) _buildTagDetails(
    BuildContext context,
    Wallet wallet,
    Transaction tx,
  ) {
    final hasSwap = tx.swapTx != null;
    final walletIsLiquid = wallet.isLiquid();

    Color colour;
    String text;

    if (hasSwap)
      text = 'Lightning';
    else if (walletIsLiquid)
      text = 'Liquid';
    else
      text = 'Bitcoin on-chain';

    if (walletIsLiquid)
      colour = CardColours.yellow;
    else
      colour = CardColours.orange;

    return (text, colour);
  }

  @override
  Widget build(BuildContext context) {
    final (name, color) = _buildTagDetails(context, wallet, tx);

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 4,
        vertical: 2,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(4),
      ),
      child: BBText.bodySmall(
        name,
        onSurface: true,
        isBold: true,
      ),
    );
  }
}

class HomeTopBar2 extends StatelessWidget {
  const HomeTopBar2({super.key});

  @override
  Widget build(BuildContext context) {
    // final network = context.select((NetworkCubit _) => _.state.getBBNetwork());
    // final totalSats = context.select((HomeCubit _) => _.state.totalBalanceSats(network));

    final currency = context.select((CurrencyCubit _) => _.state.defaultFiatCurrency);
    // final fiatCurrency = context.select((CurrencyCubit _) => _.state.defaultFiatCurrency);

    // final fiatAmt =
    // context.select((NetworkCubit _) => _.state.calculatePrice(totalSats, currency));

    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          alignment: Alignment.bottomCenter,
          margin: const EdgeInsets.only(left: 32),
          child: Image.asset(
            'assets/bb-logo2.png',
            height: 50,
            width: 50,
          ),
        ),
        const Gap(4),
        GestureDetector(
          onLongPress: () {
            context.push('/logs');
          },
          child: Container(
            alignment: Alignment.bottomCenter,
            padding: const EdgeInsets.only(left: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Image.asset(
                    'assets/textlogo.png',
                    height: 20,
                    width: 108,
                  ),
                ),
                if (currency != null)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      BBText.bodySmall(
                        currency.price.toString() + ' ' + currency.shortName.toUpperCase(),
                        // fontSize: 18,
                      ),
                      // const Gap(4),
                      // Padding(
                      //   padding: const EdgeInsets.only(bottom: 2),
                      //   child: BBText.bodySmall(
                      //     currency.shortName.toUpperCase(),
                      //   ),
                      // ),
                    ],
                  ),
              ],
            ),
          ),
        ),
        const Spacer(),
        // IconButton(
        //   key: UIKeys.homeImportButton,
        //   color: context.colour.onBackground,
        //   icon: const Icon(
        //     FontAwesomeIcons.circlePlus,
        //     shadows: [],
        //   ),
        //   onPressed: () {
        //     context.push('/import');
        //   },
        // ),
        IconButton(
          key: UIKeys.homeSettingsButton,
          color: context.colour.onBackground,
          padding: const EdgeInsets.only(bottom: 26),
          visualDensity: VisualDensity.compact,
          iconSize: 25,
          icon: const Icon(
            FontAwesomeIcons.gear,
            shadows: [],
          ),
          onPressed: () {
            context.push('/settings');
          },
        ),
        IconButton(
          iconSize: 25,

          // key: UIKeys.homeSettingsButton,
          color: context.colour.onBackground,
          visualDensity: VisualDensity.compact,

          padding: const EdgeInsets.only(bottom: 26),
          icon: const Icon(
            FontAwesomeIcons.user,
            shadows: [],
          ),
          onPressed: () {
            context.push('/market');
          },
        ),
        const Gap(24),
      ],
    );
  }
}

class HomeBottomBar2 extends StatelessWidget {
  const HomeBottomBar2({super.key, required this.walletBloc});

  final WalletBloc? walletBloc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        left: 32,
        right: 32,
        bottom: 24,
        top: 8,
      ),
      child: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: BBButton.big(
                        label: 'Receive',
                        onPressed: () {
                          context.push('/receive', extra: walletBloc);
                        },
                      ),
                    ),
                    const Gap(8),
                    Expanded(
                      child: BBButton.big(
                        label: 'Send',
                        onPressed: () {
                          context.push(
                            '/send',
                            // extra: walletBloc,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(8),
              Expanded(
                child: Row(
                  children: [
                    Expanded(
                      child: BBButton.big(
                        label: 'Buy',
                        onPressed: () {
                          context.push('/market');
                        },
                        disabled: true,
                      ),
                    ),
                    const Gap(8),
                    Expanded(
                      child: BBButton.big(
                        label: 'Sell',
                        onPressed: () {
                          context.push('/market');
                        },
                        disabled: true,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const Center(
            child: ScanButton(),
          ),
        ],
      ),
    );
  }
}

class ScanButton extends StatelessWidget {
  const ScanButton({super.key, this.walletBloc});

  final WalletBloc? walletBloc;

  @override
  Widget build(BuildContext context) {
    final darkMode =
        context.select((Lighting x) => x.state.currentTheme(context) == ThemeMode.dark);

    final bgColour = darkMode ? context.colour.background : NewColours.offWhite;

    return SizedBox(
      height: 40,
      width: 55,
      child: ElevatedButton(
        onPressed: () {
          context.push('/send', extra: 'scan');
        },
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          side: const BorderSide(color: NewColours.lightGray),
          backgroundColor: bgColour,
          surfaceTintColor: bgColour.withOpacity(0.5),
          elevation: 2,
          splashFactory: NoSplash.splashFactory,
          // foregroundColor: Colors.red,

          enableFeedback: false,
          padding: EdgeInsets.zero,
        ),
        child: Icon(
          Icons.qr_code_2,
          // FontAwesomeIcons.barcode,
          color: context.colour.onBackground,
          size: 32,
        ),
      ),
    );
  }
}

class HomeLoadingTxsIndicator extends StatefulWidget {
  const HomeLoadingTxsIndicator({super.key});

  @override
  State<HomeLoadingTxsIndicator> createState() => _HomeLoadingTxsIndicatorState();
}

class _HomeLoadingTxsIndicatorState extends State<HomeLoadingTxsIndicator> {
  bool loading = false;
  Map<String, bool> loadingMap = {};

  @override
  Widget build(BuildContext context) {
    final network = context.select((NetworkCubit x) => x.state.getBBNetwork());
    final walletBlocs = context.select((HomeCubit x) => x.state.walletBlocsFromNetwork(network));

    return MultiBlocListener(
      listeners: [
        for (final walletBloc in walletBlocs)
          BlocListener<WalletBloc, WalletState>(
            bloc: walletBloc,
            listenWhen: (previous, current) => previous.loading() != current.loading(),
            listener: (context, state) {
              if (state.loading())
                loadingMap[state.wallet!.id] = true;
              else
                loadingMap[state.wallet!.id] = false;

              if (loadingMap.values.contains(true))
                setState(() {
                  loading = true;
                });
              else
                setState(() {
                  loading = false;
                });
            },
          ),
      ],
      child: _Loading(loading: loading),
    );
  }
}

class _Loading extends StatelessWidget {
  const _Loading({required this.loading});

  final bool loading;

  @override
  Widget build(BuildContext context) {
    return !loading
        ? const SizedBox(height: 16)
        : SizedBox(
            height: 16,
            child: const BBLoadingRow().animate().fadeIn(),
          );
  }
}

class HomeNoWallets extends StatelessWidget {
  const HomeNoWallets({super.key, this.fullRed = true});

  final bool fullRed;

  @override
  Widget build(BuildContext context) {
    if (!fullRed)
      return Padding(
        padding: const EdgeInsets.all(48.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            BBButton.big(
              label: 'Create new wallet',
              onPressed: () {
                context.push('/create-wallet-main');
              },
            ),
            const Gap(16),
            BBButton.text(
              label: 'Recover wallet backup',
              centered: true,
              onPressed: () {
                context.push('/import-main');
              },
            ),
          ],
        ),
      );

    final font = GoogleFonts.bebasNeue();
    final w = MediaQuery.of(context).size.width;

    return ColoredBox(
      color: context.colour.primary,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 148,
              width: 184,
              child: Image.asset('assets/bb-white.png'),
            ),
            const Gap(24),
            Text(
              'BULL BITCOIN',
              style: font.copyWith(
                fontSize: 80,
                color: context.colour.background,
                height: 0.8,
              ),
            ),
            Text(
              'OWN YOUR MONEY',
              style: font.copyWith(
                fontSize: 59,
                height: 0.8,
              ),
            ),
            const Gap(8),
            SizedBox(
              width: w * 0.8,
              child: const BBText.body(
                'Sovereign non-custodial Bitcoin wallet and Bitcoin-only exchange service. ',
                onSurface: true,
                textAlign: TextAlign.center,
              ),
            ),
            const Gap(128),
            Center(
              child: BBButton.big(
                label: 'Create new wallet',
                onPressed: () {
                  context.push('/create-wallet-main');
                },
              ),
            ),
            BBButton.text(
              label: 'Recover wallet backup',
              centered: true,
              onSurface: true,
              isBlue: false,
              fontSize: 11,
              onPressed: () {
                context.push('/import-main');
              },
            ),
          ],
        ),
      ),
    );
  }
}

class HomeWarnings extends StatelessWidget {
  const HomeWarnings({super.key});

  @override
  Widget build(BuildContext context) {
    final network = context.select((NetworkCubit x) => x.state.getBBNetwork());
    final warnings = context.select((HomeCubit x) => x.state.homeWarnings(network));
    return Column(
      children: [
        for (final w in warnings)
          WarningBanner(
            onTap: () {
              // final bloc = w.walletBloc;
            },
            info: w.info,
          ),
      ],
    );
  }
}
