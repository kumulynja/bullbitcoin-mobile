import 'dart:io';
import 'package:bb_arch/_pkg/bb_logger.dart';
import 'package:bb_arch/_pkg/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LogListScreen extends StatelessWidget {
  const LogListScreen();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log Files'),
      ),
      body: FutureBuilder<List<File>>(
        future: BBLogger().listLogFiles(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No log files found.'));
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
                        builder: (context) => LogDetailScreen(logFile: logFile),
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
  final File logFile;

  LogDetailScreen({required this.logFile});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Log File Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.copy),
            onPressed: () async {
              final logContent = await BBLogger().readLogFile(logFile);
              BBClipboard.copy(logContent);
              print('Copied logs to clipboard');
            },
          ),
        ],
      ),
      body: FutureBuilder<String>(
        future: BBLogger().readLogFile(logFile),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Log file is empty.'));
          } else {
            return SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Text(snapshot.data!),
            );
          }
        },
      ),
    );
  }
}
