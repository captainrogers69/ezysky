import 'package:flutter/material.dart';
import 'package:squareboat/data/models/whether_model.dart';

class TravelWeatherCard extends StatelessWidget {
  final WhetherResponse? data;

  const TravelWeatherCard({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    final location = data?.location;
    final current = data?.current;

    if (location == null || current == null) {
      return const SizedBox.shrink();
    }

    final verdict = _buildVerdict(current);

    return Card(
      elevation: 6,
      margin: EdgeInsets.symmetric(horizontal: 12).copyWith(top: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// 📍 City & Time
            Text(
              "${location.name}, ${location.country}",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 4),
            Text(
              "Local time: ${location.localtime}",
              style: Theme.of(context).textTheme.bodySmall,
            ),

            const SizedBox(height: 16),

            /// 🌡️ Temperature + Condition
            Row(
              children: [
                Image.network(
                  "https:${current.condition?.icon ?? ''}",
                  height: 48,
                  width: 48,
                ),
                const SizedBox(width: 12),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${current.tempC?.toStringAsFixed(1)}°C",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    Text(
                      "Feels like ${current.feelslikeC?.toStringAsFixed(1)}°C • ${current.condition?.text}",
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),

            const Divider(height: 28),

            /// 🧭 Travel Indicators
            Wrap(
              spacing: 12,
              runSpacing: 8,
              children: [
                _chip("💨 Wind ${current.windKph} kph"),
                _chip("👀 Visibility ${current.visKm} km"),
                _chip("💧 Humidity ${current.humidity}%"),
                _chip("🌤️ UV ${current.uv}"),
                if ((current.precipMm ?? 0) > 0)
                  _chip("☔ Rain ${current.precipMm} mm"),
              ],
            ),

            const SizedBox(height: 20),

            /// ✅ Travel Verdict
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                children: [
                  const Icon(Icons.travel_explore, color: Colors.green),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      verdict,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        color: Colors.green,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  /// 🧠 Travel Logic
  String _buildVerdict(Current c) {
    final temp = c.feelslikeC ?? 0;
    final rain = c.precipMm ?? 0;
    final uv = c.uv ?? 0;
    final vis = c.visKm ?? 0;
    final wind = c.windKph ?? 0;

    if (rain > 0) return "Rain expected. Better plan indoor activities.";
    if (temp > 35) return "Very hot outside. Avoid afternoon outings.";
    if (uv > 7) return "High UV. Wear sunscreen and a cap.";
    if (vis < 2) return "Low visibility. Fog or pollution caution.";
    if (wind > 25) return "Very windy. Outdoor plans may be uncomfortable.";

    return "Perfect weather to explore the city today!";
  }

  Widget _chip(String text) {
    return Chip(
      label: Text(text),
      backgroundColor: Colors.grey.shade100,
    );
  }
}
