import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:home_service/features/worker_details/domain/entities/worker.dart';
import 'package:home_service/features/worker_details/presentation/manager/worker_cubit.dart';
import 'package:home_service/features/worker_details/presentation/manager/worker_state.dart';
import 'package:home_service/features/worker_details/presentation/pages/service_view_details.dart.dart';
import 'package:image_picker/image_picker.dart';

import '../manager/similarity_search_cubit.dart';

class SimilaritySearchPage extends StatefulWidget {
  @override
  State<SimilaritySearchPage> createState() => _SimilaritySearchPageState();
}

class _SimilaritySearchPageState extends State<SimilaritySearchPage> {
  File? _selectedImage;
  int _topK = 2;

  @override
  Widget build(BuildContext context) {
    final Color green1 = Colors.green.shade400;
    final Color green2 = Colors.green.shade600;
    final Color bg = Colors.grey[50]!;

    return Scaffold(
      backgroundColor: bg,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8),
          child: CircleAvatar(
            backgroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: green2, size: 20),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: Text('Similar Workers',
            style: TextStyle(color: green2, fontWeight: FontWeight.bold)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Gradient Header Section
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [green1, green2],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(22),
                  boxShadow: [
                    BoxShadow(
                      color: green2.withOpacity(0.13),
                      blurRadius: 15,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(13),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.22),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Icon(Icons.search, color: Colors.white, size: 30),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Find Similar Workers',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Upload an image to discover skilled workers with similar projects!',
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.9),
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 24),

              // Image Picker + Button
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: green1.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(Icons.image, color: green2, size: 22),
                        ),
                        SizedBox(width: 12),
                        Text(
                          'Upload Furniture Image',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        Spacer(),
                        if (_selectedImage != null)
                          GestureDetector(
                            child:
                                Icon(Icons.close, color: Colors.red.shade400),
                            onTap: () {
                              setState(() => _selectedImage = null);
                            },
                          )
                      ],
                    ),
                    SizedBox(height: 18),
                    GestureDetector(
                      onTap: () async {
                        final picked = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (picked != null) {
                          setState(() => _selectedImage = File(picked.path));
                          // Start the search
                          context
                              .read<SimilaritySearchCubit>()
                              .searchSimilarWorkers(_selectedImage!, _topK);
                        }
                      },
                      child: Container(
                        height: 150,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(18),
                          border: Border.all(
                            color: green1.withOpacity(0.18),
                          ),
                        ),
                        child: _selectedImage == null
                            ? Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(Icons.add_a_photo,
                                        color: green2, size: 36),
                                    SizedBox(height: 10),
                                    Text('Tap to select image',
                                        style: TextStyle(
                                            color: green2,
                                            fontWeight: FontWeight.w500)),
                                  ],
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.file(_selectedImage!,
                                    fit: BoxFit.cover),
                              ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 28),

              // Results Section
              BlocBuilder<SimilaritySearchCubit, SimilaritySearchState>(
                builder: (context, state) {
                  if (state is SimilaritySearchLoading) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 80.0),
                      child: Center(
                        child: CircularProgressIndicator(color: green2),
                      ),
                    );
                  }
                  if (state is SimilaritySearchLoaded) {
                    if (state.similarImages.isEmpty) {
                      return Padding(
                        padding: const EdgeInsets.only(top: 32),
                        child: Center(
                          child: Text('No similar workers found.',
                              style: TextStyle(color: green2, fontSize: 17)),
                        ),
                      );
                    }
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Top Matches:',
                            style: TextStyle(
                                fontSize: 19,
                                color: green2,
                                fontWeight: FontWeight.bold)),
                        SizedBox(height: 18),
                        ...state.similarImages.map((similar) {
                          // Provide WorkerCubit for each card (to fetch full info)
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 18),
                            child: BlocProvider(
                              create: (_) => WorkerCubit(
                                  getWorkerByIdUseCase: context
                                      .read<WorkerCubit>()
                                      .getWorkerByIdUseCase)
                                ..fetchWorker(
                                    int.tryParse(similar.workerId) ?? 0),
                              child: WorkerModernCard(
                                similarityScore: similar.similarityScore,
                              ),
                            ),
                          );
                        }).toList(),
                      ],
                    );
                  }
                  if (state is SimilaritySearchError) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 32),
                      child: Center(
                        child: Text('Error: ${state.message}',
                            style: TextStyle(color: Colors.red, fontSize: 16)),
                      ),
                    );
                  }
                  return Padding(
                    padding: const EdgeInsets.only(top: 36),
                    child: Center(
                        child: Text(
                            'Upload a furniture image to find similar workers.',
                            style: TextStyle(color: green2, fontSize: 16))),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Stylish Card for a Worker Profile + Similarity
class WorkerModernCard extends StatelessWidget {
  final double similarityScore;
  const WorkerModernCard({required this.similarityScore});

  @override
  Widget build(BuildContext context) {
    final Color green1 = Colors.green.shade400;
    final Color green2 = Colors.green.shade600;
    final cardColor = Colors.white;

    return BlocBuilder<WorkerCubit, WorkerState>(
      builder: (context, state) {
        if (state is WorkerLoading) {
          return Card(
            color: cardColor,
            elevation: 3,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
            child: Container(
              height: 140,
              child: Center(child: CircularProgressIndicator(color: green2)),
            ),
          );
        } else if (state is WorkerLoaded) {
          final Worker worker = state.worker;
          return InkWell(
            borderRadius: BorderRadius.circular(18),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => BlocProvider.value(
                    value: BlocProvider.of<WorkerCubit>(context),
                    child: Serviceviewdetails(
                      workerId: worker.id,
                      requestStatus: 'request',
                    ),
                  ),
                ),
              );
            },
            child: Card(
              color: cardColor,
              elevation: 4,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(18)),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header: Avatar, name, similarity
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: green1.withOpacity(0.08),
                          backgroundImage: worker.profilePictureUrl.isNotEmpty
                              ? NetworkImage(worker.profilePictureUrl)
                              : null,
                          child: worker.profilePictureUrl.isEmpty
                              ? Icon(Icons.person, color: green2, size: 30)
                              : null,
                        ),
                        SizedBox(width: 15),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(worker.name,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: green2)),
                              SizedBox(height: 3),
                              Text(worker.address,
                                  style: TextStyle(
                                      color: Colors.grey[700], fontSize: 14)),
                            ],
                          ),
                        ),
                        Container(
                          padding:
                              EdgeInsets.symmetric(vertical: 6, horizontal: 14),
                          decoration: BoxDecoration(
                            color: green1.withOpacity(0.11),
                            borderRadius: BorderRadius.circular(14),
                          ),
                          child: Text(
                              'Sim: ${(similarityScore * 100).toStringAsFixed(1)}%',
                              style: TextStyle(
                                  fontSize: 13,
                                  color: green2,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    // About
                    if (worker.description.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        child: Text(
                          worker.description,
                          style: TextStyle(color: Colors.black87, fontSize: 14),
                        ),
                      ),
                    SizedBox(height: 6),
                    // Reviews & Portfolio
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 20),
                        SizedBox(width: 5),
                        Text(worker.rating.toStringAsFixed(1),
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.amber,
                                fontSize: 15)),
                        SizedBox(width: 12),
                        Text('${worker.reviews.length} reviews',
                            style: TextStyle(color: Colors.grey[600])),
                      ],
                    ),
                    if (worker.reviews.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Row(
                          children: [
                            Icon(Icons.comment, color: green2, size: 18),
                            SizedBox(width: 7),
                            Expanded(
                              child: Text(
                                '"${worker.reviews.first.comment}"',
                                style: TextStyle(
                                    fontSize: 13, color: Colors.black87),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                    // Portfolio preview
                    if (worker.portfolioItems.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: SizedBox(
                          height: 52,
                          child: ListView.separated(
                            scrollDirection: Axis.horizontal,
                            itemCount: worker.portfolioItems.length,
                            separatorBuilder: (_, __) => SizedBox(width: 6),
                            itemBuilder: (ctx, i) {
                              final item = worker.portfolioItems[i];
                              return item.imageUrls.isNotEmpty
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(9),
                                      child: Image.network(item.imageUrls.first,
                                          width: 52,
                                          height: 52,
                                          fit: BoxFit.cover),
                                    )
                                  : Container();
                            },
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        } else if (state is WorkerError) {
          return Card(
            color: cardColor,
            child: Padding(
              padding: const EdgeInsets.all(28),
              child: Text('Failed to load worker',
                  style: TextStyle(color: Colors.red)),
            ),
          );
        }
        return SizedBox.shrink();
      },
    );
  }
}
