import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:url_launcher/url_launcher_string.dart';

class ProjectsPage extends StatelessWidget {
  const ProjectsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          spacing: 16,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Projects", style: Theme.of(context).textTheme.displayLarge),
            Divider(
              thickness: 2,
              color: Theme.of(context).colorScheme.onSurface,
            ),
            Row(
              children: [
                Text("HackITBA", style: Theme.of(context).textTheme.titleLarge),
                TextButton(
                  child: Text(
                    "See the project",
                    style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () async => await _launchInBrowser(
                    Uri.parse("https://github.com/matifere/hackitba"),
                  ),
                ),
              ],
            ),
            Text(
              "HackITBA is a hackathon organized by the ITBA Computer Science Society. It is a great opportunity to meet other students and professionals in the field of computer science and to learn new things.",
              style: Theme.of(context).textTheme.bodyMedium,
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _launchInBrowser(Uri url) async {
  if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
    throw Exception('Could not launch $url');
  }
}
