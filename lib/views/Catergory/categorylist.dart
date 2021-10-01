class Category {
  final String? emoji;
  final String? title;
  final String? desc;
  final String? id;

  Category({this.id, this.title, this.desc, this.emoji});
}

// business entertainment general health science sports technology
final categoryinfo = [
  Category(
      id: "Business",
      emoji: "💼",
      title: "Business",
      desc: "Entrepreneurship, Finance, Networking, Laws, Invest"),
  Category(
      id: "Entertainment",
      emoji: "🎸",
      title: "Entertainment",
      desc: "Pop It, Squishies, Performance, Tik-Tok"),
  Category(
      id: "General",
      emoji: "🌎",
      title: "General",
      desc: "Politics, Current events, Climate, Equality"),
  Category(
      id: "Health",
      emoji: "⚕️",
      title: "Health",
      desc: "Covid-19, Diabetes, Yoga, Fitness, Diet"),
  Category(
      id: "Science",
      emoji: "🔬",
      title: "Science",
      desc: "Earth, Humans, Life, Math, Physics, Chemistry, Space"),
  Category(
      id: "Sports",
      emoji: "🏏",
      title: "Sports",
      desc: "Cricket, Soccer, MMA, Tennis, NFL, BasketBall"),
  Category(
      id: "Technology",
      emoji: "💻",
      title: "Technology",
      desc: "Startups, Neuralink, Mars Rover, Audi, Apple, Amazon"),
  Category(
      id: "Entertainment",
      emoji: "🎬",
      title: "Cinema",
      desc: "Marvel, DC, Warner Bros, Apple TV+, Netflix, HBO"),
];
