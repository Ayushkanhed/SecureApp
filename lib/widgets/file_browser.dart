import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

class FileBrowser extends StatefulWidget {
  const FileBrowser({Key? key}) : super(key: key);

  @override
  State<FileBrowser> createState() => _FileBrowserState();
}

class _FileBrowserState extends State<FileBrowser> {
  List<FileSystemEntity> _files = [];

  @override
  void initState() {
    super.initState();
    _loadFiles();
  }

  Future<void> _loadFiles() async {
    final dir = await getApplicationDocumentsDirectory();
    final allFiles = Directory(dir.path).listSync();
    setState(() {
      _files = allFiles..sort((a, b) => b.statSync().modified.compareTo(a.statSync().modified));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Saved Evidence'),
        actions: [
          IconButton(
              onPressed: _loadFiles,
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: _files.isEmpty
          ? const Center(child: Text('No evidence files saved yet.'))
          : ListView.builder(
              itemCount: _files.length,
              itemBuilder: (context, index) {
                final f = _files[index];
                final name = f.uri.pathSegments.last;
                final size = f.statSync().size;
                return ListTile(
                  leading: Icon(
                    name.endsWith('.png')
                        ? Icons.image
                        : (name.endsWith('.aac') ? Icons.audiotrack : Icons.lock),
                    color: Colors.indigo,
                  ),
                  title: Text(name),
                  subtitle: Text('${(size / 1024).toStringAsFixed(1)} KB'),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      await f.delete();
                      _loadFiles();
                    },
                  ),
                  onTap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('File tapped: $name')));
                  },
                );
              },
            ),
    );
  }
}
