import 'package:flutter/material.dart';
import 'dart:io';

class FileUpload extends StatefulWidget {
  final ValueChanged<File>? onFileSelected;
  final String? label;
  final List<String>? acceptedTypes;

  const FileUpload({
    super.key,
    this.onFileSelected,
    this.label,
    this.acceptedTypes,
  });

  @override
  State<FileUpload> createState() => _FileUploadState();
}

class _FileUploadState extends State<FileUpload> {
  File? _selectedFile;

  Future<void> _pickFile() async {
    // Note: This is a placeholder. In a real app, you'd use file_picker package
    // For now, this demonstrates the structure
    // You would need to add: file_picker: ^5.0.0 to pubspec.yaml
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null) ...[
          Text(
            widget.label!,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
        ],
        InkWell(
          onTap: _pickFile,
          child: Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
                style: BorderStyle.solid,
                width: 2,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(Icons.upload_file, size: 24),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _selectedFile != null
                            ? _selectedFile!.path.split('/').last
                            : 'Choose file',
                        style: TextStyle(
                          fontSize: 14,
                          color: _selectedFile != null ? Colors.black : Colors.grey,
                        ),
                      ),
                      if (_selectedFile == null)
                        const Text(
                          'No file selected',
                          style: TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}





