import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pharus/constant/colors.dart';
import 'package:pharus/controllers/career_controller.dart';
import 'package:pharus/models/career_model.dart';
import 'package:pharus/ui/screens/career_detail.dart';
import 'package:pharus/ui/screens/results.dart';
import 'package:provider/provider.dart';

class RecommendCareer extends StatefulWidget {
  static const id = 'RecommendCareer';
  String code;
  String area;
  RecommendCareer(this.code, this.area);

  @override
  _RecommendCareerState createState() => _RecommendCareerState();
}

class _RecommendCareerState extends State<RecommendCareer> {
  List title = [
    'Agricultural Inspectors',
    'Bicycle Repairers',
    'Carpenters',
    'Biomass Plant Technicians',
  ];
  List subtitle = [
    'Inspect agricultural commodities,processing equipment,and facilities,to ensure compliance with regulations and laws governing health,quality,and safety'
  ];

  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) async {
      final proivder = Provider.of<CareerController>(context, listen: false);
      proivder.getUserCareer(widget.code, widget.area, context);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CareerController>(builder: (context, value, child) {
      if (value.statusUser == StatusCareer.loading) {
        return Scaffold(
          body: Center(
            child: CircularProgressIndicator(),
          ),
        );
      }
      if (value.statusUser == StatusCareer.error) {
        return Scaffold(
          body: Center(
            child: Text('Error in data'),
          ),
        );
      }

      return Scaffold(
        body: SafeArea(
          child: Column(
            // crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(20),
                child: Text(
                    "Careers that fit your interests and perparation level:",
                    style: TextStyle(
                        color: Colors.grey.shade600,
                        fontSize: 15,
                        fontWeight: FontWeight.w400)),
              ),
              Expanded(
                child: ListView.builder(
                    itemCount: value.career.length,
                    itemBuilder: (context, index) {
                      return CardData(
                          career: value.career[index],
                          index: (index + 1).toString(),
                          title: value.career[index].title,
                          subtitle: value.career[index].description);
                    }),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class CardData extends StatelessWidget {
  CardData(
      {@required this.index,
      @required this.title,
      @required this.subtitle,
      @required this.career});
  String index;
  String title;
  String subtitle;
  CareerModel career;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 3),
      child: InkWell(
        borderRadius: BorderRadius.circular(15),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CareerDetails(
                      career: career,
                      index: index,
                    )),
          );
          // Navigator.pushNamed(context, CareerDetails.id);
        },
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          color: circle,
          child: ListTile(
            leading: CircleAvatar(
              child: Text(
                index,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w400),
              ),
            ),
            title: Padding(
              padding: const EdgeInsets.fromLTRB(8, 20, 0, 8),
              child: Text('$title',
                  style: TextStyle(
                      color: Colors.teal,
                      fontSize: 15,
                      fontWeight: FontWeight.w600)),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Text('$subtitle'),
            ),
            isThreeLine: true,
          ),
        ),
      ),
    );
  }
}
