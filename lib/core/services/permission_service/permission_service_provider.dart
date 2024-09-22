import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:scrapwala_dev/core/services/permission_service/permission_service.dart';

final permissionServiceProvider = Provider<PermissionService>((ref) {
  return PermissionService();
});
