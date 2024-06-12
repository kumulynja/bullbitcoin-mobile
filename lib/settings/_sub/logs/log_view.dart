import 'dart:io';
import 'package:bb_arch/_pkg/bb_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogListScreen extends StatelessWidget {
  const LogListScreen();

  @override
  Widget build(BuildContext context) {
    final BBLogger logger = RepositoryProvider.of<BBLogger>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Files'),
      ),
      body: FutureBuilder<List<File>>(
        future: logger.listLogFiles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No log files found.'));
          } else {
            final logFiles = snapshot.data!;
            return ListView.builder(
              itemCount: logFiles.length,
              itemBuilder: (context, index) {
                final logFile = logFiles[index];
                return ListTile(
                  title: Text(logFile.path.split('/').last),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            LogDetailScreen(logger: logger, logFile: logFile),
                      ),
                    );
                  },
                );
              },
            );
          }
        },
      ),
    );
  }
}

class LogDetailScreen extends StatelessWidget {
  final BBLogger logger;
  final File logFile;

  LogDetailScreen({required this.logger, required this.logFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Log File Details'),
      ),
      body: FutureBuilder<String>(
        future: logger.readLogFile(logFile),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('Log file is empty.'));
          } else {
            return SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Text(snapshot.data!),
            );
          }
        },
      ),
    );
  }
}
