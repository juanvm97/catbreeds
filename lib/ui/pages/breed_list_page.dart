import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:catbreeds/ui/widgets/breed_item.dart';
import 'package:catbreeds/providers/breed_provider.dart';

class BreedListPage extends StatefulWidget {
  const BreedListPage({super.key});

  @override
  State<BreedListPage> createState() => _BreedListPageState();
}

class _BreedListPageState extends State<BreedListPage> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    final breedProvider = context.read<BreedProvider>();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      breedProvider.fetchBreeds();
    });
    _scrollController.addListener(() {
      if (_scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          breedProvider.query.isEmpty) {
        breedProvider.fetchMoreBreeds();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Catbreeds'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(64.0),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 16.0,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextField(
                onChanged: (value) {
                  Provider.of<BreedProvider>(context, listen: false)
                      .searchBreeds(value);
                  _scrollController.jumpTo(0.0);
                },
                decoration: const InputDecoration(
                  hintText: 'Buscar...',
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.search),
                  contentPadding: EdgeInsets.all(10.0),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Consumer<BreedProvider>(
        builder: (context, breedProvider, child) {
          if (breedProvider.breeds.isEmpty && breedProvider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (breedProvider.breeds.isEmpty) {
            return Center(
              child: Image.asset(
                'assets/images/breed_not_found.png',
                fit: BoxFit.cover,
              ),
            );
          } else if (breedProvider.errorMessage != null) {
            return Center(child: Text(breedProvider.errorMessage!));
          } else {
            return ListView.separated(
              controller: _scrollController,
              itemCount: breedProvider.breeds.length + 1,
              itemBuilder: (context, index) {
                if (index == breedProvider.breeds.length) {
                  return Center(
                    child: breedProvider.isLoading
                        ? const Padding(
                            padding: EdgeInsets.symmetric(vertical: 32.0),
                            child: CircularProgressIndicator(),
                          )
                        : const SizedBox.shrink(),
                  );
                }
                final breed = breedProvider.breeds[index];
                return BreedItem(
                  breed: breed,
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
            );
          }
        },
      ),
    );
  }
}
