import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:home_service/core/error/failures.dart';
import 'package:home_service/features/worker_details/domain/entities/worker.dart';
import 'package:home_service/features/worker_details/domain/usecases/get_worker_by_id.dart';
import 'package:home_service/features/worker_details/presentation/pages/service_view_details.dart.dart';

class WorkerSearchResultsList extends StatelessWidget {
  final List<int> workerIds;
  const WorkerSearchResultsList({required this.workerIds, super.key});

  @override
  Widget build(BuildContext context) {
    if (workerIds.isEmpty) {
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: 16),
        child: Text('No matching workers found.'),
      );
    }
    return ListView.builder(
      // shrinkWrap: true,
      // physics: const NeverScrollableScrollPhysics(),
      itemCount: workerIds.length,
      itemBuilder: (context, index) {
        return FutureBuilder(
          future:
              RepositoryProvider.of<GetWorkerById>(context)(workerIds[index]),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const ListTile(title: Text('Loading...'));
            }
            final result = snapshot.data as Either<Failure, Worker>;
            return result.fold(
              (failure) => const ListTile(title: Text('Error loading worker')),
              (worker) => ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => Serviceviewdetails(workerId: worker.id,requestStatus: 'request'),
                    ),
                  );
                },
                leading: worker.profilePictureUrl.isNotEmpty
                    ? CircleAvatar(
                        backgroundImage: NetworkImage(worker.profilePictureUrl))
                    : const CircleAvatar(
                        backgroundColor:
                            Color(0xFF16A637), // Replace with your app's green
                        radius: 22, // adjust for size
                        child: Icon(Icons.person, color: Colors.white),
                      ),
                title: Text(worker.name),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${worker.serviceName} • ${worker.city}'),
                    const SizedBox(height: 2),
                    Text(
                      worker.description.length > 60
                          ? '${worker.description.substring(0, 60)}...'
                          : worker.description,
                      style:
                          const TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                  ],
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.star, color: Colors.amber, size: 18),
                    Text(worker.rating.toString()),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
