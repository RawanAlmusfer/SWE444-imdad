import 'package:flutter/material.dart';
import 'package:adobe_xd/pinned.dart';
import 'package:flutter_svg/flutter_svg.dart';

class XDCardChris extends StatelessWidget {
  XDCardChris({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Pinned.fromPins(
          Pin(start: 0.0, end: 0.0),
          Pin(start: 0.0, end: 0.0),
          child:
              // Adobe XD layer: 'card' (shape)
              SvgPicture.string(
            _svg_g9md7s,
            allowDrawingOutsideViewBox: true,
            fit: BoxFit.fill,
          ),
        ),
        Pinned.fromPins(
          Pin(size: 57.6, end: 23.2),
          Pin(size: 18.6, end: 9.6),
          child:
              // Adobe XD layer: 'icn_like' (group)
              Stack(
            children: <Widget>[
              Pinned.fromPins(
                Pin(size: 32.0, start: 0.0),
                Pin(start: 1.3, end: 1.3),
                child:
                    // Adobe XD layer: 'شارك' (text)
                    Text(
                  'شارك',
                  style: TextStyle(
                    fontFamily: 'Rift Soft',
                    fontSize: 12,
                    color: const Color(0xff65afaf),
                    letterSpacing: 1.7999999999999998,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              Pinned.fromPins(
                Pin(size: 18.6, end: 0.0),
                Pin(start: 0.0, end: 0.0),
                child:
                    // Adobe XD layer: 'Icon awesome-donate' (shape)
                    SvgPicture.string(
                  _svg_fjir,
                  allowDrawingOutsideViewBox: true,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
        Pinned.fromPins(
          Pin(start: 0.0, end: 0.0),
          Pin(size: 1.0, middle: 0.7796),
          child: SvgPicture.string(
            _svg_w7am,
            allowDrawingOutsideViewBox: true,
            fit: BoxFit.fill,
          ),
        ),
        Pinned.fromPins(
          Pin(size: 86.5, start: 15.0),
          Pin(size: 31.0, middle: 0.2207),
          child:
              // Adobe XD layer: 'messaging' (group)
              Stack(
            children: <Widget>[
              Pinned.fromPins(
                Pin(start: 0.0, end: 2.5),
                Pin(size: 13.0, end: 0.0),
                child: Text.rich(
                  TextSpan(
                    style: TextStyle(
                      fontFamily: 'Europa',
                      fontSize: 10,
                      color: const Color(0xff334856),
                    ),
                    children: [
                      TextSpan(
                        text: 'in Alyasmin, ',
                        style: TextStyle(
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      TextSpan(
                        text: 'Riyadh',
                        style: TextStyle(
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ],
                  ),
                  textHeightBehavior:
                      TextHeightBehavior(applyHeightToFirstAscent: false),
                  textAlign: TextAlign.center,
                ),
              ),
              Pinned.fromPins(
                Pin(start: 11.5, end: 0.0),
                Pin(size: 14.0, start: 0.0),
                child: Text(
                  'مسجد أحمد الدامغ',
                  style: TextStyle(
                    fontFamily: 'Europa',
                    fontSize: 10,
                    color: const Color(0xff334856),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
            ],
          ),
        ),
        Pinned.fromPins(
          Pin(size: 74.0, start: 15.0),
          Pin(size: 11.0, end: 4.0),
          child: Text(
            '12/09/21 10:47 AM',
            style: TextStyle(
              fontFamily: 'Europa',
              fontSize: 9,
              color: const Color(0xff798186),
              fontWeight: FontWeight.w300,
            ),
            textAlign: TextAlign.left,
          ),
        ),
        Pinned.fromPins(
          Pin(size: 151.0, end: 20.7),
          Pin(size: 36.0, start: 22.1),
          child: Stack(
            children: <Widget>[
              Pinned.fromPins(
                Pin(size: 95.0, start: 0.0),
                Pin(size: 28.0, end: 0.0),
                child: Text(
                  'تغيير سجاد ',
                  style: TextStyle(
                    fontFamily: 'Europa',
                    fontSize: 20,
                    color: const Color(0xff334856),
                    fontWeight: FontWeight.w700,
                  ),
                  textAlign: TextAlign.right,
                ),
              ),
              Pinned.fromPins(
                Pin(size: 45.0, end: 0.0),
                Pin(start: 0.0, end: 0.0),
                child:
                    // Adobe XD layer: 'Icon awesome-mosque' (shape)
                    SvgPicture.string(
                  _svg_av2f6,
                  allowDrawingOutsideViewBox: true,
                  fit: BoxFit.fill,
                ),
              ),
            ],
          ),
        ),
        Pinned.fromPins(
          Pin(start: 33.7, end: 32.7),
          Pin(size: 15.0, middle: 0.588),
          child:
              // Adobe XD layer: 'progress bar' (group)
              Stack(
            children: <Widget>[
              Pinned.fromPins(
                Pin(start: 60.0, end: 60.0),
                Pin(size: 11.0, end: 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14.0),
                    color: const Color(0xfff4f3f3),
                    border:
                        Border.all(width: 1.0, color: const Color(0xfff4f3f3)),
                  ),
                ),
              ),
              Pinned.fromPins(
                Pin(size: 134.0, middle: 0.3315),
                Pin(size: 11.0, end: 0.0),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(14.0),
                      bottomLeft: Radius.circular(14.0),
                    ),
                    color: const Color(0xffd97d54),
                  ),
                ),
              ),
              Pinned.fromPins(
                Pin(size: 52.0, end: 0.0),
                Pin(start: 0.0, end: 0.0),
                child: Text(
                  '5000 SAR',
                  style: TextStyle(
                    fontFamily: 'Europa',
                    fontSize: 12,
                    color: const Color(0xff798186),
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
              Pinned.fromPins(
                Pin(size: 52.0, start: 0.0),
                Pin(start: 0.0, end: 0.0),
                child: Text(
                  '4000 SAR',
                  style: TextStyle(
                    fontFamily: 'Europa',
                    fontSize: 12,
                    color: const Color(0xffd97d54),
                    fontWeight: FontWeight.w300,
                  ),
                  textAlign: TextAlign.left,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

const String _svg_fjir =
    '<svg viewBox="61.0 1.3 18.6 18.6" ><path transform="translate(61.0, 1.29)" d="M 9.2930908203125 15.10127258300781 C 13.46409225463867 15.10127258300781 16.84372711181641 11.72163772583008 16.84372711181641 7.550636291503906 C 16.84372711181641 3.379635572433472 13.46409225463867 0 9.2930908203125 0 C 5.122089862823486 0 1.742454528808594 3.379635810852051 1.742454528808594 7.550636291503906 C 1.742454528808594 11.72163772583008 5.122090339660645 15.10127258300781 9.2930908203125 15.10127258300781 Z M 8.487205505371094 3.535730600357056 L 8.487205505371094 2.925871849060059 C 8.487205505371094 2.591901302337646 8.755834579467773 2.323272705078125 9.089803695678711 2.323272705078125 L 9.492746353149414 2.323272705078125 C 9.826717376708984 2.323272705078125 10.09534454345703 2.591901063919067 10.09534454345703 2.925871849060059 L 10.09534454345703 3.542990922927856 C 10.65801239013672 3.57203197479248 11.20252895355225 3.764427900314331 11.65629386901855 4.102028369903564 C 11.85957908630371 4.250863075256348 11.88136100769043 4.548532485961914 11.69985485076904 4.722777843475342 L 11.10814762115479 5.285445213317871 C 10.97020435333252 5.419759750366211 10.76328754425049 5.423389434814453 10.59993171691895 5.321746826171875 C 10.40390491485596 5.198322772979736 10.1860990524292 5.136610984802246 9.953771591186523 5.136610984802246 L 8.541656494140625 5.136610984802246 C 8.214946746826172 5.136610984802246 7.949949264526367 5.434280395507812 7.949949264526367 5.800921440124512 C 7.949949264526367 6.098591327667236 8.131454467773438 6.363589286804199 8.389191627502441 6.439821720123291 L 10.65075302124023 7.118653297424316 C 11.58369255065918 7.398171901702881 12.2371129989624 8.294809341430664 12.2371129989624 9.300351142883301 C 12.2371129989624 10.53458976745605 11.27876281738281 11.53287124633789 10.09171581268311 11.56554222106934 L 10.09171581268311 12.17540073394775 C 10.09171581268311 12.50937175750732 9.823086738586426 12.77799892425537 9.489117622375488 12.77799892425537 L 9.086175918579102 12.77799892425537 C 8.752204895019531 12.77799892425537 8.483576774597168 12.50937080383301 8.483576774597168 12.17540073394775 L 8.483576774597168 11.55828094482422 C 7.92090892791748 11.52924060821533 7.376391887664795 11.3368444442749 6.922627925872803 10.99924373626709 C 6.71934175491333 10.85040950775146 6.697560787200928 10.55273914337158 6.879065990447998 10.37849426269531 L 7.47077465057373 9.815826416015625 C 7.608718872070312 9.681511878967285 7.815635681152344 9.677883148193359 7.978991031646729 9.779525756835938 C 8.175017356872559 9.902949333190918 8.392824172973633 9.964661598205566 8.625150680541992 9.964661598205566 L 10.03726482391357 9.964661598205566 C 10.36397552490234 9.964661598205566 10.62897396087646 9.666991233825684 10.62897396087646 9.300350189208984 C 10.62897396087646 9.002680778503418 10.44746780395508 8.737683296203613 10.18972969055176 8.661450386047363 L 7.928169727325439 7.982619762420654 C 6.995230197906494 7.703100204467773 6.341809749603271 6.806462287902832 6.341809749603271 5.800920963287354 C 6.345439910888672 4.5666823387146 7.300159454345703 3.568401098251343 8.48720645904541 3.535730123519897 Z M 17.42454528808594 12.778000831604 L 16.24475860595703 12.778000831604 C 15.53325748443604 13.72182941436768 14.62572860717773 14.50956439971924 13.59477615356445 15.10127258300781 L 15.91078758239746 15.10127258300781 C 16.10318374633789 15.10127258300781 16.25927734375 15.23195648193359 16.25927734375 15.39168167114258 L 16.25927734375 15.97249984741211 C 16.25927734375 16.13222694396973 16.10318374633789 16.26290893554688 15.91078758239746 16.26290893554688 L 2.67176365852356 16.26290893554688 C 2.479367733001709 16.26290893554688 2.323272705078125 16.13222694396973 2.323272705078125 15.97249984741211 L 2.323272705078125 15.39168167114258 C 2.323272705078125 15.23195648193359 2.479367733001709 15.10127258300781 2.67176365852356 15.10127258300781 L 4.987776756286621 15.10127258300781 C 3.956824541091919 14.50956439971924 3.052926063537598 13.72182941436768 2.337793588638306 12.778000831604 L 1.161636352539062 12.778000831604 C 0.5191062688827515 12.778000831604 0 13.29710578918457 0 13.93963623046875 L 0 17.42454528808594 C 0 18.06707572937012 0.5191062688827515 18.586181640625 1.161636352539062 18.586181640625 L 17.42454528808594 18.586181640625 C 18.06707572937012 18.586181640625 18.586181640625 18.06707572937012 18.586181640625 17.42454528808594 L 18.586181640625 13.93963623046875 C 18.586181640625 13.29710578918457 18.06707572937012 12.778000831604 17.42454528808594 12.778000831604 Z" fill="#65afaf" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_g9md7s =
    '<svg viewBox="0.0 0.0 381.5 168.4" ><defs><filter id="shadow"><feDropShadow dx="0" dy="5" stdDeviation="10"/></filter></defs><path  d="M 16.93047332763672 0 L 364.5695190429688 0 C 373.9199829101562 0 381.5 6.715729713439941 381.5 15 L 381.5 153.396484375 C 381.5 161.6807556152344 373.9199829101562 168.396484375 364.5695190429688 168.396484375 L 16.93047332763672 168.396484375 C 7.580032348632812 168.396484375 0 161.6807556152344 0 153.396484375 L 0 15 C 0 6.715729713439941 7.580032348632812 0 16.93047332763672 0 Z" fill="#ffffff" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" filter="url(#shadow)"/></svg>';
const String _svg_w7am =
    '<svg viewBox="0.0 130.5 381.5 1.0" ><path transform="translate(0.0, 130.5)" d="M 0 0 L 381.5 0" fill="none" stroke="#f0f3f4" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
const String _svg_av2f6 =
    '<svg viewBox="315.8 22.1 45.0 36.0" ><path transform="translate(315.76, 22.13)" d="M 0 33.75 C 0 34.9924201965332 1.007578134536743 36 2.25 36 L 6.75 36 C 7.992422103881836 36 9 34.9924201965332 9 33.75 L 9 11.25 L 0 11.25 L 0 33.75 Z M 40.72218704223633 20.25 C 41.97797012329102 19.02726554870605 42.75 17.62453079223633 42.75 16.10789108276367 C 42.75 12.39117240905762 39.81164169311523 9.51328182220459 36.56812286376953 7.466485023498535 C 33.61921691894531 5.605313301086426 30.89882659912109 3.404531955718994 28.6959342956543 0.7010164260864258 L 28.125 0 L 27.55406188964844 0.7010156512260437 C 25.35117149353027 3.404531240463257 22.63148307800293 5.606015682220459 19.6818733215332 7.466484069824219 C 16.4383602142334 9.513280868530273 13.5 12.3911714553833 13.5 16.10789108276367 C 13.5 17.62453079223633 14.2720308303833 19.02726554870605 15.52781295776367 20.25 L 40.72218704223633 20.25 Z M 42.75 22.5 L 13.5 22.5 C 12.25757789611816 22.5 11.25 23.50757789611816 11.25 24.75 L 11.25 33.75 C 11.25 34.9924201965332 12.25757789611816 36 13.5 36 L 15.75 36 L 15.75 31.5 C 15.75 30.25757789611816 16.75757789611816 29.25 18 29.25 C 19.24242210388184 29.25 20.25 30.25757789611816 20.25 31.5 L 20.25 36 L 24.75 36 L 24.75 30.9375 C 24.75 27.5625 28.125 25.875 28.125 25.875 C 28.125 25.875 31.5 27.5625 31.5 30.9375 L 31.5 36 L 36 36 L 36 31.5 C 36 30.25757789611816 37.0075798034668 29.25 38.25 29.25 C 39.4924201965332 29.25 40.5 30.25757789611816 40.5 31.5 L 40.5 36 L 42.75 36 C 43.9924201965332 36 45 34.9924201965332 45 33.75 L 45 24.75 C 45 23.50757789611816 43.9924201965332 22.5 42.75 22.5 Z M 4.5 0 C 4.5 0 0 2.25 0 6.75 L 0 9 L 9 9 L 9 6.75 C 9 2.25 4.5 0 4.5 0 Z" fill="#d97d54" stroke="none" stroke-width="1" stroke-miterlimit="4" stroke-linecap="butt" /></svg>';
