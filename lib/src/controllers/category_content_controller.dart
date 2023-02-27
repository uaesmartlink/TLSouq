import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';
import 'package:TLSouq/src/models/all_category_product_model.dart';
import 'package:TLSouq/src/servers/repository.dart';

import '../models/product_by_category_model.dart';

class CategoryContentController extends GetxController {
  final categoryList = <Categories>[].obs;
  final productList = <CategoryProductData>[].obs;
  final Rx<FeaturedCategory> featuredCategory = FeaturedCategory().obs;
  bool get isLoading => _isLoading.value;
  final _isLoading = true.obs;
  int page = 1;
  int pageProduct = 0;
  ScrollController scrollController = ScrollController();
  ScrollController scrollControllerProducts = ScrollController();
  var isMoreDataAvailable = true.obs;
  var isMoreDataLoading = false.obs;
  var isMoreProductsAvailable = true.obs;
  var isMoreProductsLoading = false.obs;

  var featuredIndex = true.obs;
  var index = 1.obs;

  updateIndex(int value) {
    index.value = value;
    update();
  }

  updateFeaturedIndexData(bool value) {
    featuredIndex(value);
    update();
  }

  @override
  void onInit() {
    getCatProducts();
    paginateTask();
    paginateTaskProducts();
    super.onInit();
  }

  void paginateTask() {
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        if (isMoreDataAvailable.value) {
          page++;
          getMoreData(page);
        }
      }
    });
  }

  void paginateTaskProducts() {
    scrollControllerProducts.addListener(() {
      if (scrollControllerProducts.position.pixels ==
          scrollControllerProducts.position.maxScrollExtent) {
        if (isMoreDataAvailable.value) {
          pageProduct++;
          getMoreProducts(categoryList[index.value].id!,pageProduct);
        }
      }
    });
  }

  Future<void> getMoreProducts(int id, int page) async {
    isMoreDataLoading(true);
    await Repository().getProductByCategoryItem(id: id , page: page).then((value) {

      if (value != null) {
        if (value.isNotEmpty) {
          productList.addAll(value);
          isMoreProductsAvailable(true);
          isMoreProductsLoading(true);
        } else {
          isMoreProductsAvailable(false);
          isMoreProductsLoading(false);
        }
      } else {
        isMoreProductsAvailable(false);
        isMoreProductsLoading(false);
      }
    });
  }
  getCatProducts() async {
    _isLoading(true);
    await Repository().getAllCategoryContent(page: page).then((value) {
      if (value != null && value.data != null) {
        featuredCategory.value = value.data!.featuredCategory!;
        categoryList.clear();
        categoryList.addAll(value.data!.categories!);
      }
    });

    _isLoading(false);
  }

  Future<List<CategoryProductData>> getProductByCategory(int id) async {
    return await Repository()
        .getProductByCategoryItem(id: id, page: 0);
  }

  Future<void> getMoreData(int page) async {
    isMoreDataLoading(true);
    await Repository().getAllCategoryContent(page: page).then((value) {
      if (value != null && value.data != null) {
        if (value.data!.categories!.isNotEmpty) {
          categoryList.addAll(value.data!.categories!);
          isMoreDataAvailable(true);
          isMoreDataLoading(true);
        } else {
          isMoreDataAvailable(false);
          isMoreDataLoading(false);
        }
      } else {
        isMoreDataAvailable(false);
        isMoreDataLoading(false);
      }
    });
  }
}
