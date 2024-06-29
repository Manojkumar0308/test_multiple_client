class Client {
  final String id;
  final String text;
  final int lightState;
  final double temperature;
  final double humidity;
  final int timestamp;

  Client({required this.id, required this.text, required this.lightState, required this.temperature, required this.humidity, required this.timestamp});

  factory Client.fromJson(Map<String, dynamic> json) {
    return Client(
      id: json['id'],
      text: json['data']['text'],
      lightState: json['data']['lightState'],
      temperature: json['data']['temperature'],
      humidity: json['data']['humidity'],
      timestamp: json['data']['timestamp'],
    );
  }
}