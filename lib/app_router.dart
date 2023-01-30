import 'package:dictionary_b2_v1/block/main_block.dart';
import 'package:dictionary_b2_v1/form/topic_add_edit.dart';
import 'package:dictionary_b2_v1/form/topic_view.dart';
import 'package:dictionary_b2_v1/model/topic.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppRouter {
  int selectIndex = 0;

  final DataCubitDictionary shopCubit = DataCubitDictionary(KeeperDictionary());
  Route onGenerateRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: shopCubit,
            child: TopicView(selectedIndex: selectIndex),
          ),
        );

      case '/ShopMain':
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(value: shopCubit, child: null
              //  ShopMain(
              //   selectedIndex: selectIndex,
              // ),
              ),
        );

      case '/TopicAddEdit':
        final Topic topic = routeSettings.arguments as Topic;
        return MaterialPageRoute(
          builder: (context) => TopicAddEdit(
            topic: topic,
          ),
        );

//       case '/Cart':
//         return MaterialPageRoute(
//           builder: (context) => BlocProvider.value(
//             value: shopCubit,
//             child: Cart(
//               selectedIndex: selectIndex,
//             ),
//           ),
//         );

//       case '/ProductView':
//         return MaterialPageRoute(
//           builder: (context) => ProductView(
//             selectedIndex: selectIndex,
//           ),
//         );

//       case '/OrdersForm':
//         return MaterialPageRoute(
//           builder: (context) => BlocProvider.value(
//             value: shopCubit,
//             child: OrdersForm(
//               selectedIndex: selectIndex,
//             ),
//           ),
//         );

//       case OrderDetailForm.route_name:
//         final order_head head = routeSettings.arguments as order_head;
//         return MaterialPageRoute(
//           builder: (context) => OrderDetailForm(
//             order: head,
//           ),
//         );

//       // case '/OrderDetailForm':
//       //   return MaterialPageRoute(
//       //     builder: (context) => OrderDetailForm(
//       //       order: head,
//       //     ),
//       //   );

      default:
        return MaterialPageRoute(
          builder: (context) => BlocProvider.value(
            value: shopCubit,
            child: TopicView(selectedIndex: selectIndex),
          ),
        );
    }
  }
}
