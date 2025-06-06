class Message {
  final String image;
  final String vendorImage;
  final String name;
  final String date;
  final String description;
  final String duration;

  Message({
    required this.image,
    required this.vendorImage,
    required this.name,
    required this.date,
    required this.description,
    required this.duration,
  });
}
final List<Message> messages = [
  Message(
      image: "https://www.momondo.in/himg/b1/a8/e3/revato-1172876-6930557-765128.jpg",
      vendorImage: "https://images.ctfassets.net/h6goo9gw1hh6/2sNZtFAWOdP1lmQ33VwRN3/24e953b920a9cd0ff2e1d587742a2472/1-intro-photo-final.jpg?w=1200&h=992&fl=progressive&q=70&fm=jpg",
      name: "Andrew",
      date: "7/25/23",
      description: "You: Cozygo reservation of the",
      duration: "Sep 24-28, 2024 Stockach",
  ),
  Message(
    image: "https://radissonhotels.iceportal.com/image/radisson-hotel-kathmandu/exterior/16256-114182-f75152296_3xl.jpg",
    vendorImage: "https://www.perfocal.com/blog/content/images/size/w960/2021/01/Perfocal_17-11-2019_TYWFAQ_100_standard-3.jpg",
      name: "Nikolus",
      date: "23/25/23",
      description: "CozyGo update: Reminder leave about",
      duration: "Sep 22-25, 2024 Konstanz",
  ),
  Message(
      image: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRgCXf3HATaGRx4_GtvzW8FVnYfXKRQMuRzOg&s",
      vendorImage: "https://shotkit.com/wp-content/uploads/bb-plugin/cache/cool-profile-pic-matheus-ferrero-landscape-6cbeea07ce870fc53bedd94909941a4b-zybravgx2q47.jpeg",
      name: "Gabby",
      date: "11/20/24",
      description: "You: Cozygo reservation of the",
      duration: "Sep 21-22, 2024 Khajura",
  ),
];
