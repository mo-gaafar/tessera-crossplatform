import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:tessera/features/Booking/view/widgets/reuseable_events.dart';
import 'package:tessera/features/Booking/view/widgets/event_page.dart';
import 'package:tessera/features/Booking/view/widgets/see_more.dart';
import 'package:tessera/constants/app_colors.dart';

class SeemoreScreen extends StatelessWidget {
  const SeemoreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: AppBar(
              elevation: 3,
              title: Text(
                'books',
                style: TextStyle(
                    fontFamily: 'NeuePlak', color: Colors.white, fontSize: 25),
              ),
              leading: Icon(Icons.close),
              backgroundColor: AppColors.primary,
            ),
            body: SeeMore(
              seemoreText:
                  'seemoreTextqwkjfg.kqjebd.kqsnbj.fb,JSNVFC.KAjhgsfkjkewb/lkehlfkjknewrgtkhlijbgtlerkgf,jhjfiubwgjr;ngqrjbgq.rng/krjg/qrkng/kngsufakuyewfvblueygflqjhjvbeflyglehvflajhhgqlhvfljhbdf;lhjfegrliyuigflekjbflhqegvf;kjqwebflhjgq;elgj;ewrjgtlqiuewggfbljhjbgerliguhq;kjgbleryugt;eqlwuibflgkwjehf;eqigitliugrljkbcq;kejgliuihjeabed;EIHPEUIGH;Ailhqfq;kukgeqlfiuh;dsgh;KJH;LKH;ojbjg;JJBG;Jkbg;JBG;jbg;WJGBFS;JGB;EJNV;AKBKG;KJB',
              timeText: '9:00 AM-12:00 PM GMT +02:00',
              dateText: 'Wed, March 15-Thu, March 16',
            )));
  }
}
