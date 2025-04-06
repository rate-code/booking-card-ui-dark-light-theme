import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:testing/constants.dart';

class StaticBookingsScreen extends StatefulWidget {
  const StaticBookingsScreen({super.key});

  @override
  State<StaticBookingsScreen> createState() => _StaticBookingsScreenState();
}

class _StaticBookingsScreenState extends State<StaticBookingsScreen> {
  bool isDarkMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isDarkMode ? Colors.black : Colors.white,
      body: Container(
        padding: EdgeInsets.all(5.w),
        height: 100.h,
        width: 100.w,
        child: Column(
          children: [
            SizedBox(height: MediaQuery.of(context).viewPadding.top),
            Row(
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      isDarkMode = !isDarkMode;
                    });
                  },
                  child: Container(
                    height: 50,
                    width: 90.w,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(2.5.w),
                    ),
                    child: Center(
                      child: Text(
                        "Toggle Theme",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 5.w),
            Expanded(
              child: ListView.builder(
                padding: EdgeInsets.zero,
                itemCount: dummyBookings.length,
                itemBuilder: (context, index) {
                  final booking = dummyBookings[index];
                  return Column(
                    children: [
                      _buildSingleBookingCard(booking),
                      SizedBox(height: 5.w),
                    ],
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSingleBookingCard(Map<String, dynamic> booking) {
    const double boxHeight = 200;

    Color statusColor =
        booking['status'] == "CANCELLED" ? Colors.red : Colors.green;

    DateTime startTime = booking['startTime'];

    return Row(
      children: [
        Container(
          width: 20.w,
          height: boxHeight,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(booking['venueImage']),
              fit: BoxFit.cover,
            ),
            border: Border.all(color: statusColor, width: 2),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(5.w),
              bottomLeft: Radius.circular(5.w),
            ),
          ),
        ),
        SizedBox(width: 2.5.w),
        Expanded(
          child: Container(
            height: boxHeight,
            decoration: BoxDecoration(
              color: isDarkMode ? Colors.black : Colors.white,
              border: Border.all(color: statusColor, width: 2),
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(5.w),
                bottomRight: Radius.circular(5.w),
              ),
            ),
            padding: EdgeInsets.all(2.5.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      "assets/icons/football.svg",
                      height: 20,
                      width: 20,
                      color: statusColor,
                    ),
                    SizedBox(width: 2.5.w),
                    Text(
                      "Football",
                      style: TextStyle(
                        color: statusColor,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 5.w),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Booking #${booking['id'].substring(booking['id'].length - 8)}",
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 2.5.w),
                          Text(
                            booking['street'],
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "${booking['city']}, ${booking['postalCode']}",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Text(
                            "${_formatDate(startTime)}",
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(width: 2.w),
                          Container(
                            height: 20,
                            width: 1.5,
                            color: Colors.grey,
                          ),
                          SizedBox(width: 2.w),
                          Text(
                            "${_formatTime(startTime)}",
                            style: TextStyle(
                              color: isDarkMode ? Colors.white : Colors.black,
                              fontSize: 15.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _formatDate(DateTime dt) {
    return "${_getWeekday(dt.weekday)}, ${dt.day} ${_getMonth(dt.month)}";
  }

  String _formatTime(DateTime dt) {
    return "${dt.hour % 12 == 0 ? 12 : dt.hour % 12}:${dt.minute.toString().padLeft(2, '0')} ${dt.hour >= 12 ? 'PM' : 'AM'}";
  }

  String _getWeekday(int day) {
    const days = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"];
    return days[day - 1];
  }

  String _getMonth(int month) {
    const months = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    return months[month - 1];
  }
}
