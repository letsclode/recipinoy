import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../providers/feedback/feedback_stream_provider.dart';
import 'feedback_table.dart';

class FeedbackScreen extends ConsumerStatefulWidget {
  const FeedbackScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends ConsumerState<FeedbackScreen> {
  @override
  Widget build(BuildContext context) {
    final feedbackProvider = ref.watch(feedbacksProvider);

    return feedbackProvider.when(
        data: (value) => FeedbackTable(
              title: 'Feedbacks',
              headers: const [
                'User',
                'Description',
                'Screenshot',
              ],
              data: value,
            ),
        error: (error, stackTrace) => Text('Error: $error'),
        loading: () => Center(child: CircularProgressIndicator()));
  }
}
