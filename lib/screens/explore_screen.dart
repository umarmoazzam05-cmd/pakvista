import 'package:flutter/material.dart';
import 'tourist_spot.dart';
import 'tourist_spots_data.dart';
import 'map_screen.dart';

class ExploreScreen extends StatefulWidget {
  final List<TouristSpot> favourites;
  final Function(List<TouristSpot>) onFavouritesUpdated;
  final VoidCallback? onBackToHome;

  const ExploreScreen({
    super.key,
    required this.favourites,
    required this.onFavouritesUpdated,
    this.onBackToHome,
  });

  @override
  State<ExploreScreen> createState() => _ExploreScreenState();
}

class _ExploreScreenState extends State<ExploreScreen> {
  late List<TouristSpot> spots;

  @override
  void initState() {
    super.initState();

    spots = allTouristSpots.map(
      (spot) => TouristSpot(
        title: spot.title,
        description: spot.description,
        location: spot.location,
        latitude: spot.latitude,
        longitude: spot.longitude,
        isFavorite: widget.favourites.any((f) => f.title == spot.title),
      ),
    ).toList();
  }

  Widget buildCard(TouristSpot spot) {
    return GestureDetector(
      onTap: () {
        // Show place details when card is tapped
        showDialog(
          context: context,
          builder: (_) => AlertDialog(
            title: Text(spot.title),
            content: SingleChildScrollView(
              child: Text(
                spot.description + "\n\nLocation: ${spot.location}",
                style: const TextStyle(fontSize: 14),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text("Close"),
              ),
            ],
          ),
        );
      },
      child: Card(
        elevation: 6,
        margin: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: const Icon(
                  Icons.place,
                  size: 32,
                  color: Colors.green,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      spot.title,
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      spot.description,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey[700],
                        height: 1.3,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on,
                          size: 16,
                          color: Colors.green,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          spot.location,
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  spot.isFavorite ? Icons.favorite : Icons.favorite_border,
                  color: Colors.red,
                ),
                onPressed: () {
                  setState(() {
                    spot.isFavorite = !spot.isFavorite;
                  });
                  widget.onFavouritesUpdated(
                    spots.where((s) => s.isFavorite).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            if (widget.onBackToHome != null) {
              widget.onBackToHome!(); // return to home
            } else {
              Navigator.pop(context);
            }
          },
        ),
        title: const Text(
          "Explore",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Text(
                  "Explore breathtaking spots in Pakistan",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: spots.length,
                  itemBuilder: (context, index) => buildCard(spots[index]),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: 25,
            right: 20,
            child: Material(
              elevation: 8,
              shape: const CircleBorder(),
              color: Colors.green,
              child: InkWell(
                customBorder: const CircleBorder(),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => MapScreen(spots: spots),
                    ),
                  );
                },
                child: const SizedBox(
                  width: 65,
                  height: 65,
                  child: Icon(
                    Icons.map,
                    color: Colors.white,
                    size: 32,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
