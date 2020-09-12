import 'package:charts_flutter/flutter.dart' as charts;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:school_admin_web/Color.dart';
import 'package:school_admin_web/Responsive.dart';
import 'package:school_admin_web/Screen/AcademicYear/AcademicYearChangeNotifier.dart';
import 'package:school_admin_web/Screen/AcademicYear/Model/AcademicYearModel.dart';
import 'package:school_admin_web/Screen/AcademicYear/ViewModel/CrudViewModel.dart';
import 'package:shimmer/shimmer.dart';

import 'GenderRatioBarChart.dart';
import 'TimeSeriesChart.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GetTracker getmetrics = GetTracker();

  @override
  Widget build(BuildContext context) {


    return Expanded(
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Color(0xffFFFFFF),
            boxShadow: [
              BoxShadow(
                  color: Color(0xff707070).withOpacity(.4),
                  offset: Offset(-8, 3),
                  blurRadius: 12),
            ]),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  academicYearMetrics(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 300,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(32.0),
                            color: Color(0xff6B778D).withOpacity(.4),
                            boxShadow: [
                              BoxShadow(
                                color: Color(0xff707070).withOpacity(.4),
                                offset: Offset(0, 0),
                                blurRadius: 6,
                              ),
                            ]),
                        child: SizedBox(
                          height: SizeConfig.hp(6),
                          child: TextField(
                            cursorColor: AppColors.white,
                            style: TextStyle(
                              fontSize: 18,
                              color: AppColors.white,
                              letterSpacing: .2,
                            ),
                            enabled: true,
                            decoration: InputDecoration(
                              hintText: 'Search',
                              hintStyle: TextStyle(
                                fontSize: 15,
                                color: AppColors.white,
                                letterSpacing: .2,
                              ),
                              contentPadding: const EdgeInsets.only(
                                left: 20,
                                right: 20,
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(32.0),
                                borderSide: BorderSide.none,
                              ),
                            ),
                            onChanged: (value) {},
                            onSubmitted: (value) {},
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        width: 75,
                        height: 40,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Color(0xffFF6768),
                            boxShadow: [
                              BoxShadow(
                                  color: Color(0xff000000).withOpacity(.4),
                                  offset: Offset(0, 0),
                                  blurRadius: 6),
                            ]),
                        child: Icon(
                          Icons.search,
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 40,
              ),
              child: Divider(
                thickness: .5,
                color: Color(0xff6B778D).withOpacity(.5),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView(
                scrollDirection: Axis.vertical,
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  studentAttendanceMetrics(metricsName: 'Present', value: '50'),
                  SizedBox(
                    height: 20,
                  ),
                  studentAttendanceMetrics(metricsName: 'Absent', value: '60'),
//                  Padding(
//                    padding: const EdgeInsets.symmetric(
//                        horizontal: 180, vertical: 50),
//                    child: lineChart(),
//                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    child: Row(
                      children: [
                        Text(
                          'Student Growth',
                          style: TextStyle(
                              color: Color(0xff263859),
                              fontSize: SizeConfig.textScaleFactor * 30,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Divider(
                              thickness: .5,

                              color: Color(0xff6B778D).withOpacity(.5),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        left: 155,right: 100,top: 10 ,bottom: 10),
                    child: getMetricTrend(metricTrends: getmetrics.data),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    child: Row(
                      children: [
                        Text(
                          'Gender Ratio',
                          style: TextStyle(
                              color: Color(0xff263859),
                              fontSize:  SizeConfig.textScaleFactor * 30,
                              letterSpacing: 1,
                              fontWeight: FontWeight.bold),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(left: 20),
                            child: Divider(
                              thickness: .5,
                              height: .5,
                              color: Color(0xff6B778D).withOpacity(.5),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 155,right: 100,top: 20 ,bottom: 20),
                    child: genderRatioMetrics(
                        malePercentage: '60%',
                        femalePercentage: '39%',
                        otherPercentage: '1%'),
                  ),
                  SizedBox(
                    height: 200,
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget academicYearMetrics() {
    final academicYearProvider = Provider.of<AcademicYearViewModel>(context,listen: false);
    final academicId  = Provider.of<YearNotifier>(context,listen: true);
     return Container(
      height: 80,
      width: 175,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
                color: Color(0xff707070).withOpacity(.4),
                offset: Offset(1, 1),
                blurRadius: 3),
            BoxShadow(
              color: Color(0xff707070).withOpacity(.4),
              offset: Offset(-1, -1),
              blurRadius: 3,
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Academic Year',
              style: TextStyle(
                  color: Color(0xffFF6768),
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
            FutureBuilder(
              future: academicYearProvider.getYearById(academicId.getYearId()),
               builder: (context,AsyncSnapshot<AcademicModel> snapshot){
               if(snapshot.hasData){
                 return Text(
                   snapshot.data.year,
                   style: TextStyle(
                       color: Color(0xff263859),
                       fontSize: 30,
                       fontWeight: FontWeight.bold),
                 );
               }
               else return Text(
                 'Loading.',
                 style: TextStyle(
                     color: Color(0xff263859),
                     fontSize: 30,
                     fontWeight: FontWeight.bold),
               );
               },
            ),
          ],
        ),
      ),
    );
  }

  Widget studentAttendanceMetrics({String metricsName, String value}) {
    return Padding(
      padding: const EdgeInsets.only(left: 150),
      child: Container(
        width: double.infinity,
        height: SizeConfig.hp(8),
        child: Stack(
          children: [
            Container(
              width: 150,
              decoration: BoxDecoration(
                color: Color(0xffFF6768),
                borderRadius: BorderRadius.circular(10),
                // border: Border.all(color: Color(0xff707070)),
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 2,horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(metricsName,
                            overflow: TextOverflow.visible,
                            softWrap: false,
                            maxLines: 1,
                            style: TextStyle(
                                color: AppColors.white,
                                fontSize: SizeConfig.textScaleFactor * 12,
                                fontWeight: FontWeight.w400,
                                letterSpacing: .2)),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 30),
                          child: Text(value,
                              style: TextStyle(
                                color: AppColors.white,
                                fontSize: 30,
                              )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            Positioned(
              left: 115,
              child: Container(
                width: SizeConfig.wp(50),
                height: SizeConfig.hp(8),
                decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.all(Radius.circular(15)),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xff707070).withOpacity(.4),
                          offset: Offset(1, 1),
                          blurRadius: 5),
                      BoxShadow(
                        color: Color(0xff707070).withOpacity(.4),
                        offset: Offset(-1, -1),
                        blurRadius: 5,
                      )
                    ]),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text('Class',
                              overflow: TextOverflow.visible,
                              softWrap: false,
                              maxLines: 1,
                              style: TextStyle(
                                color: Color(0xff263859),
                                fontSize: 12,
                              )),
                          Text(metricsName,
                              overflow: TextOverflow.visible,
                              softWrap: false,
                              maxLines: 1,
                              style: TextStyle(
                                color: metricsName == 'Absent'
                                    ? Color(0xffFF6768)
                                    : Color(0xff39CE15),
                                fontSize: 12,
                              )),
                        ],
                      ),
                    ),
                    Container(
                      width: 1,
                      height: 30,
                      color: Color(0xff6B778D),
                    ),
                    Expanded(
                      child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: classList.length,
                          separatorBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Container(
                                width: 1,
                                color: Color(0xff6B778D),
                              ),
                            );
                          },
                          itemBuilder: (context, index) {
                            List<String> absent = metrics();
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 5, vertical: 8),
                              child: Container(
                                height: 70,
                                width: 80,
                                alignment: Alignment.center,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(classList[index].className,
                                        overflow: TextOverflow.visible,
                                        softWrap: false,
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: Color(0xff263859),
                                          fontSize: 12,
                                        )),
                                    Text(absent[index],
                                        overflow: TextOverflow.visible,
                                        softWrap: false,
                                        maxLines: 1,
                                        style: TextStyle(
                                          color: metricsName == 'Absent'
                                              ? Color(0xffFF6768)
                                              : Color(0xff39CE15),
                                          fontSize: 12,
                                        )),
                                  ],
                                ),
                              ),
                            );
                          }),
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget getMetricTrend({List<MetricTrend> metricTrends}) {
    if (metricTrends.length > 2) {
      var transformedTrends = transformToLineTimeChartSeries(metricTrends);
      return Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: PointLineTimeSeriesChart(seriesList: transformedTrends),
      );
    }
    return SizedBox();
  }

  dynamic transformToLineTimeChartSeries(List<MetricTrend> trends) {
    // var formattedDate = DateFormat("y-M-dTH:m:sZ");
    return [
      charts.Series(
        id: 'student Count',
        colorFn: (_, __) => charts.Color.fromHex(code: "#FF6768"),
        domainFn: (MetricTrend trend, _) => DateTime.parse(trend.time),
        measureFn: (MetricTrend trend, _) => trend.targetProgressValue,
        data: trends,
        strokeWidthPxFn: (MetricTrend trend, _) => 2,
        radiusPxFn: (MetricTrend trend, _) => 3,
      ),
    ];
  }

  Widget genderRatioMetrics(
      {String malePercentage,
      String femalePercentage,
      String otherPercentage}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
            height: 350,
            width: SizeConfig.wp(30),
            child: StackedFillColorBarChart(
              createSampleData(),
              animate: true,
            )),
        Container(
          height: SizeConfig.hp(30),
          width: SizeConfig.wp(20),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: AppColors.white,
              boxShadow: [
                BoxShadow(
                  color: Color(0xff707070).withOpacity(.4),
                  offset: Offset(0, 0),
                  blurRadius: 15,
                )
              ]),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
            child: Row(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CircleAvatar(
                            child: Text(
                              malePercentage,
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                            radius: 20,
                            backgroundColor: Color(0xffFF6768)),
                        CircleAvatar(
                            child: Text(
                              femalePercentage,
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                            radius: 20,
                            backgroundColor: Color(0xff263859)),
                        CircleAvatar(
                            child: Text(
                              otherPercentage,
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w400),
                            ),
                            radius: 20,
                            backgroundColor: Color(0xff6B778D)),
                      ],
                    )
                  ],
                ),
                Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          'MALE',
                          style: TextStyle(
                            color: Color(0xffFF6768),
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'FEMALE',
                          style: TextStyle(
                            color: Color(0xff263859),
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Text(
                          'Other',
                          style: TextStyle(
                            color: Color(0xff6B778D),
                            fontSize: 25,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
              ],
            ),
          ),
        )
      ],
    );
  }
}

class Class {
  String id;
  String yearId;
  String className;
  Class({this.id, this.className, this.yearId});
}

List<Class> classList = [
  Class(id: UniqueKey().toString(), className: 'One', yearId: '0'),
  Class(id: UniqueKey().toString(), className: 'Two(A)', yearId: '0'),
  Class(id: UniqueKey().toString(), className: 'Two(B)', yearId: '0'),
  Class(id: UniqueKey().toString(), className: 'Two(C)', yearId: '1'),
  Class(id: UniqueKey().toString(), className: 'Three', yearId: '2'),
  Class(id: UniqueKey().toString(), className: 'Four(A)', yearId: '3'),
  Class(id: UniqueKey().toString(), className: 'Four(B)', yearId: '3'),
  Class(id: UniqueKey().toString(), className: 'Five', yearId: '4'),
  Class(id: UniqueKey().toString(), className: 'Six', yearId: '5'),
  Class(id: UniqueKey().toString(), className: 'Seven', yearId: '6'),
  Class(id: UniqueKey().toString(), className: 'Eight', yearId: '7'),
  Class(id: UniqueKey().toString(), className: 'Nine', yearId: '8'),
  Class(id: UniqueKey().toString(), className: 'Ten', yearId: '9'),
];
List<String> metrics() {
  List<String> absent = [];
  for (Class item in classList) {
    absent.add("60");
  }
  return absent;
}
