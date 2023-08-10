import 'package:coding_factory_train/common/const/data.dart';
import 'package:coding_factory_train/product/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductScreen extends ConsumerStatefulWidget {
  const ProductScreen({super.key});

  @override
  ConsumerState createState() => _ProductScreenState();
}

class _ProductScreenState extends ConsumerState<ProductScreen> {


  @override
  Widget build(BuildContext context) {
    final state = ref.watch(productProvider);
    logger.d(state);
    return const Center(child: Text("음식"));
  }
}
