import 'dart:async';
import 'package:flutter/material.dart';
import 'package:jeddah_mosques/providers/district_provider.dart';
import 'package:jeddah_mosques/providers/mosque_provider.dart';
import 'package:jeddah_mosques/widgets/mosque_info.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isInit = true;
  bool isLoading = false;
  bool isListLoading = false;
  bool isBtnLoading = false;
  int selectedIndex = -1;
  String? currentDistrict = "";
  
  @override
  void didChangeDependencies() {
    if (isInit) {
      isInit = false;
      setState(() {
        isLoading = true;
      });
      final mosqueProvider = Provider.of<MosuqeProvider>(context);
      final districtProvider = Provider.of<DistrictProvider>(context);
      mosqueProvider.fetchMosques();
      districtProvider.fetchDistricts(context);
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final mp = Provider.of<MosuqeProvider>(context);
    final dp = Provider.of<DistrictProvider>(context);
    return Scaffold(
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: Container(
            color: Color(0xff182444),
            child: Padding(
                padding: const EdgeInsets.only(
                    left: 15, right: 15, top: 8, bottom: 8),
                child: Row(
                  children: [
                    Image.asset('./assets/traweeh.png'),
                  ],
                )),
          )),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: Color(0xff182444),
              ),
            )
          : Padding(
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 25),
                    Text(
                      "اختر الحي",
                      style:
                          TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    _districtFilter(dp),
                    const SizedBox(height: 25),
                    _headersRow(),
                    isListLoading
                        ? const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: Color(0xff182444),
                              ),
                            ),
                          )
                        : ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: mp.mosquesList.length,
                            itemBuilder: (context, index) {
                              return selectedIndex != -1
                                  ? currentDistrict ==
                                          mp.mosquesList[index].districtID
                                      ? MosqueInfo(
                                          mosque: mp.mosquesList[index])
                                      : Container()
                                  : MosqueInfo(mosque: mp.mosquesList[index]);
                            }),
                            isBtnLoading 
                            ? Center(child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(color: Color(0xff182444),),
                            ),) 
                            : currentDistrict == "" 
                            ? Center(
                              child: Container(
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(5),
                                width: 100,
                                decoration: BoxDecoration(
                                  color: Color(0xff182444),
                                  borderRadius: BorderRadius.circular(5)
                                ),
                                child: TextButton(
                                  onPressed: () {
                                    setState(() {
                                      isBtnLoading = true;
                                    });
                                    mp.fetchNextMosques(context);
                                    setState(() {
                                      isBtnLoading = false;
                                    });
                                  },
                                  child: Text("تحميل المزيد", style: TextStyle(color: Colors.white),)
                                  ),
                              ),
                            ) : Container()
                  ],
                ),
              ),
            ),
    );
  }

  Widget _headersRow() {
    return Row(
      children: const [
        CustomHeader(text: 'اسم الامام',),
        CustomHeader(text: 'اسم المسجد',),
        CustomHeader(text: 'الحي',),
        CustomHeader(text: 'صوت الامام',),
        CustomHeader(text: 'المصليات',),
        CustomHeader(text: 'الموقع',),

      ],
    );
  }

  Widget _districtFilter(DistrictProvider dp) {
    return Container(
      height: 40,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: dp.districtList.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (selectedIndex == index) {
                  setState(() {
                    isListLoading = true;
                    selectedIndex = -1;
                  });
                  currentDistrict = "";
                  Future.delayed(const Duration(milliseconds: 500), () {
                    setState(() {
                      isListLoading = false;
                    });
                  });
                } else {
                  setState(() {
                    isListLoading = true;
                    selectedIndex = index;
                  });
                  currentDistrict = dp.districtList[index].districtID;
                  Future.delayed(const Duration(milliseconds: 500), () {
                    setState(() {
                      isListLoading = false;
                    });
                  });
                }
              },
              child: Row(
                children: [
                  Container(
                      // width: 80,
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: selectedIndex == index
                              ? Color(0xff182444)
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Color(0xff182444))),
                      child: Center(
                        child: Text(
                          "حي ${dp.districtList[index].districtName}",
                          style: TextStyle(
                              color: selectedIndex == index
                                  ? Colors.white
                                  : Colors.black),
                        ),
                      )),
                  SizedBox(width: 10)
                ],
              ),
            );
          }),
    );
  }
}

class CustomHeader extends StatelessWidget {
  final String text;
  const CustomHeader({
    Key? key,required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(6),
        decoration: BoxDecoration(
            color: Color(0xffbc9c64),
            border: Border.all(color: Colors.white, width: 2)),
        child: Center(
          child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 95) {
              return SelectableText(
                text,
                style: const TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white),
              );
            } else {
              return SelectableText(
                  text,
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.white, fontSize: width >= 1080? 8 :6 ),
              );
            }
          },
        )
        ),
      ),
    );
  }
}
