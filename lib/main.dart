import 'package:flutter/material.dart';

enum CvSection { about, contact, experience }

class CvSlidePage extends StatefulWidget {
  const CvSlidePage({super.key});

  @override
  State<CvSlidePage> createState() => _CvSlidePageState();
}

class _CvSlidePageState extends State<CvSlidePage> {
  CvSection _currentSection = CvSection.about;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            // LEFT MENU
            Container(
              width: 260,
              color: const Color(0xFF2E3A4E),
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage('assets/profile.jpg'),
                  ),
                  const SizedBox(height: 30),

                  _menuButton("About Me", CvSection.about),
                  _menuButton("Experience", CvSection.experience),
                  _menuButton("Contact", CvSection.contact),
                ],
              ),
            ),

            // RIGHT CONTENT (SLIDE)
            Expanded(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 400),
                transitionBuilder: (child, animation) {
                  final offsetAnimation = Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(animation);

                  return SlideTransition(
                    position: offsetAnimation,
                    child: child,
                  );
                },
                child: _buildSection(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- MENU BUTTON ----------------
  Widget _menuButton(String title, CvSection section) {
    final isActive = _currentSection == section;

    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor:
              isActive ? Colors.blue : Colors.blueGrey.shade700,
          minimumSize: const Size(double.infinity, 45),
        ),
        onPressed: () {
          setState(() {
            _currentSection = section;
          });
        },
        child: Text(title),
      ),
    );
  }

  // ---------------- SECTION SWITCH ----------------
  Widget _buildSection() {
    switch (_currentSection) {
      case CvSection.about:
        return _aboutSection();
      case CvSection.experience:
        return _experienceSection();
      case CvSection.contact:
        return _contactSection();
    }
  }

  // ---------------- SECTIONS ----------------
  Widget _aboutSection() {
    return _sectionContainer(
      key: const ValueKey("about"),
      title: "About Me",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("Name : Meas Bunthorng"),
          Text("Gender : Male"),
          Text("Age : 21"),
          Text("Major : Telecommunication Engineering"),
        ],
      ),
    );
  }

  Widget _experienceSection() {
    return _sectionContainer(
      key: const ValueKey("experience"),
      title: "Experience",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("• Seller at dessert shop"),
          Text("• Math teacher (Grade 6)"),
          Text("• OOP, Microcontroller, Sensor"),
          Text("• Analog & Digital Electronics"),
        ],
      ),
    );
  }

  Widget _contactSection() {
    return _sectionContainer(
      key: const ValueKey("contact"),
      title: "Contact",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text("📞 031 850 0140"),
          Text("✉ bunthorngmeas@gmail.com"),
          Text("📍 Phnom Penh, Cambodia"),
        ],
      ),
    );
  }
  // ---------------- COMMON CONTAINER ----------------
  Widget _sectionContainer({
    required Widget child,
    required String title,
    required Key key,
  }) {
    return Container(
      key: key,
      padding: const EdgeInsets.all(30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const Divider(),
          const SizedBox(height: 15),
          child,
        ],
      ),
    );
  }
}