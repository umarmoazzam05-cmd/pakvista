import 'package:flutter/material.dart';
import 'tourist_spot.dart';

class FavouritesScreen extends StatefulWidget {
  final List<TouristSpot> favourites;
  final Function(List<TouristSpot>) onFavouritesUpdated;

  const FavouritesScreen({
    super.key,
    required this.favourites,
    required this.onFavouritesUpdated,
  });

  @override
  State<FavouritesScreen> createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        centerTitle: true,
        title: const Text(
          "Favourites",
          style: TextStyle(color: Colors.white, fontSize: 20),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);   // Safe back navigation
          },
        ),
      ),

      body: Column(
        children: [
          const SizedBox(height: 12),

          const Text(
            "Your Favourite Spots",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),

          Expanded(
            child: widget.favourites.isEmpty
                ? const Center(
                    child: Text(
                      "No favourites yet.",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: widget.favourites.length,
                    itemBuilder: (context, index) {
                      final spot = widget.favourites[index];

                      return Container(
                        margin: const EdgeInsets.only(bottom: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 8,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),

                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // LEFT – Static Heart Icon
                            const Padding(
                              padding: EdgeInsets.all(16),
                              child: Icon(
                                Icons.favorite,
                                color: Colors.red,
                                size: 70,
                              ),
                            ),

                            // MIDDLE – DETAILS
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(top: 16, bottom: 16),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      spot.title,
                                      style: const TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 6),

                                    Text(
                                      spot.description,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: Colors.grey[700],
                                      ),
                                    ),
                                    const SizedBox(height: 8),

                                    Text(
                                      "Location: ${spot.location}",
                                      style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),

                            // RIGHT – Remove Favourite
                            IconButton(
                              icon: Icon(
                                spot.isFavorite
                                    ? Icons.favorite
                                    : Icons.favorite_border,
                                color: Colors.red,
                                size: 30,
                              ),
                              onPressed: () {
                                setState(() {
                                  spot.isFavorite = !spot.isFavorite;

                                  if (!spot.isFavorite) {
                                    widget.favourites.removeAt(index);
                                  }

                                  widget.onFavouritesUpdated(
                                      widget.favourites);
                                });
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
