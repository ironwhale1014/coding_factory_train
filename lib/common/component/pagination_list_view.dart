import 'package:coding_factory_train/common/const/colors.dart';
import 'package:coding_factory_train/common/model/cursor_pagination_model.dart';
import 'package:coding_factory_train/common/model/model_with_id.dart';
import 'package:coding_factory_train/common/provider/pagination_provider.dart';
import 'package:coding_factory_train/common/util/pagination_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

typedef PaginationWidgetBuilder<T extends IModelWithId> = Widget Function(
    BuildContext context, int index, T model);

class PaginationListView<T extends IModelWithId>
    extends ConsumerStatefulWidget {
  const PaginationListView(
      {required this.itemBuilder, required this.provider, super.key});

  final StateNotifierProvider<PaginationProvider, CursorPaginationBase>
      provider;

  final PaginationWidgetBuilder<T> itemBuilder;

  @override
  ConsumerState createState() => _PaginationListViewState<T>();
}

class _PaginationListViewState<T extends IModelWithId>
    extends ConsumerState<PaginationListView<T>> {
  ScrollController controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.addListener(listener);
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.removeListener(listener);
    controller.dispose();
  }

  void listener() {
    PaginationUtils.paginate(
        controller: controller, provider: ref.read(widget.provider.notifier));
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(widget.provider);
    if (state is CursorPaginationLoading) {
      return const Center(
        child: CircularProgressIndicator(color: PRIMARY_COLOR),
      );
    }

    if (state is CursorPaginationError) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(state.message, textAlign: TextAlign.center),
          const SizedBox(
            height: 16,
          ),
          ElevatedButton(
              onPressed: () {
                ref.read(widget.provider.notifier).paginate(forceRefech: true);
              },
              child: const Text("다시 시도하기"))
        ],
      );
    }

    final cp = state as CursorPagination<T>;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: ListView.separated(
          controller: controller,
          itemBuilder: (_, index) {
            if (index == cp.data.length) {
              return Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Center(
                    child: cp is CursorPaginationfetchingMore
                        ? const CircularProgressIndicator()
                        : const Text("마지막 데이터 입니다.")),
              );
            }

            final pItem = cp.data[index];
            return widget.itemBuilder(context, index, pItem);
          },
          separatorBuilder: (_, index) => const SizedBox(height: 10),
          itemCount: cp.data.length + 1),
    );
  }
}
