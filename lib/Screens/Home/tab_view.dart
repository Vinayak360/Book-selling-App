import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Constants/products_model.dart';
import '../../Models/products_model.dart';

import '../../Widgets/Tabs/Books PDF/books_pdfs_tab.dart';
import '../../Widgets/Tabs/Buy Books/buy_books_tab.dart';
import '../../Widgets/Tabs/Question Papers/question_paper_tab.dart';
import '../../Widgets/Tabs/Syllabus/syllabus_tab.dart';

class TabViewScreen extends StatefulWidget {
  final String semester;
  final String subject;
  const TabViewScreen({Key? key, required this.semester, required this.subject})
      : super(key: key);

  @override
  State<TabViewScreen> createState() => _TabViewScreenState();
}

class _TabViewScreenState extends State<TabViewScreen>
    with SingleTickerProviderStateMixin {
  late TabController _controller;
  @override
  void initState() {
    // TODO: implement initState
    _controller = TabController(length: 4, vsync: this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Product> prod = productData
        .where(
            (e) => e.semester == widget.semester && e.subject == widget.subject)
        .toList();
    print(prod);

    print(widget.semester);
    print(widget.subject);

    return SafeArea(
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(
              height: 5,
            ),
            Container(
              child: TabBar(
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
                indicatorColor: Colors.red,
                controller: _controller,
                tabs: [
                  const Tab(
                    text: "Buy Books",
                  ),
                  const Tab(
                    text: "Book PDF'S",
                  ),
                  const Tab(
                    text: "Question papers",
                  ),
                  const Tab(
                    text: "Syllabus",
                  ),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                controller: _controller,
                children: [
                  BuyBooksTab(
                    semester: widget.semester,
                    subject: widget.subject,
                  ),
                  const BooksPDFTab(),
                  const QuestionPapersTab(),
                  SyllabusTab(
                    semester: widget.semester,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
