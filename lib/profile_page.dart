import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: CircleAvatar(
              radius: 60,
              backgroundImage: const AssetImage("assets/profile.jpeg"),
            ),
          ),

          IntrinsicWidth(
            child: Column(
              spacing: 16,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "Matias Ferechian",
                  style: Theme.of(context).textTheme.displayLarge,
                ),
                Text(
                  "Full Stack Developer",
                  style: Theme.of(context).textTheme.displayMedium,
                ),
                Divider(
                  thickness: 2,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                Text("About Me", style: Theme.of(context).textTheme.titleLarge),
                SizedBox(
                  width: 600,
                  child: Text(
                    "Hello, I'm Matias Ferechian, a Flutter Developer with a passion for creating beautiful and user-friendly applications. I have experience in building a wide range of applications, from simple to complex, and I am always looking for new challenges to take on. I am also a fan of the latest trends in the Flutter ecosystem and I am always looking for new ways to improve my skills.",
                    maxLines: 5,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                Divider(
                  thickness: 2,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                Text("Skills", style: Theme.of(context).textTheme.titleLarge),
                Text(
                  "Languages: Dart, Java, C#, JavaScript",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  "Frameworks: Flutter, Node.js, Unity ",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  "Tools: Git, Bloc, Firebase, Google Cloud",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                // ! studies
                Divider(
                  thickness: 2,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                Text("Studies", style: Theme.of(context).textTheme.titleLarge),
                Text(
                  "Bachiller en Ciencias de la Computacion, Instituto Dante Alighieri, Bariloche",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  "Licenciatura en Ciencias de la Computacion, Universidad De Buenos Aires, Buenos Aires",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  'Flutter course, Domestika, Online',
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                // ! contact
                Divider(
                  thickness: 2,
                  color: Theme.of(context).colorScheme.onSurface,
                ),
                Text("Contact", style: Theme.of(context).textTheme.titleLarge),
                Text(
                  "Email: matifere@gmail.com",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  "Linkedin: www.linkedin.com/in/matías-ferechian",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                Text(
                  "Github: github.com/matifere",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
