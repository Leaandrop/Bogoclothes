import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../core/colors.dart';
import '../core/routes.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  File? _profileImage;

  // Avatar: permite escoger imagen de galería
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      setState(() {
        _profileImage = File(picked.path);
      });
      // Opcional: guarda ruta local en SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('profile_image', picked.path);
    }
  }

  // Al iniciar: carga ruta local de imagen si hay
  @override
  void initState() {
    super.initState();
    _loadProfileImage();
  }

  Future<void> _loadProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    final path = prefs.getString('profile_image');
    if (path != null && File(path).existsSync()) {
      setState(() {
        _profileImage = File(path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundLight,
      appBar: AppBar(
        title: const Text('Mi Perfil', style: TextStyle(fontFamily: 'RobotoSlab')),
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // STACK: Tarjeta + Avatar flotante con botón de cámara
            Stack(
              clipBehavior: Clip.none,
              children: [
                // Tarjeta principal
                Container(
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                  padding: const EdgeInsets.only(top: 56, left: 18, right: 18, bottom: 24),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    color: AppColors.backgroundLight.withOpacity(0.93),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primary.withOpacity(0.08),
                        blurRadius: 12,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 30),
                      Text(
                        'Alejandro Jiménez',
                        style: TextStyle(
                          fontSize: 24,
                          color: AppColors.primary,
                          fontFamily: 'RobotoSlab',
                          fontWeight: FontWeight.bold,
                          letterSpacing: 0.7,
                        ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'alejandro06181125@gmail.com',
                        style: TextStyle(color: Colors.white70, fontFamily: 'RobotoSlab'),
                      ),
                      const SizedBox(height: 18),
                      // Stats rápidos: Favoritos y Pedidos (puedes adaptar los valores)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _statBox(Icons.favorite, '8', 'Favoritos', color: Colors.red),
                          _statBox(Icons.shopping_bag, '5', 'Pedidos', color: AppColors.primary),
                        ],
                      ),
                    ],
                  ),
                ),
                // Avatar flotante y botón editar imagen
                Positioned(
                  left: MediaQuery.of(context).size.width / 2 - 48,
                  top: -36,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(4),
                        decoration: BoxDecoration(
                          color: AppColors.backgroundLight,
                          borderRadius: BorderRadius.circular(50),
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.primary.withOpacity(0.12),
                              blurRadius: 8,
                            ),
                          ],
                        ),
                        child: CircleAvatar(
                          radius: 44,
                          backgroundColor: Colors.white,
                          backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
                          child: _profileImage == null
                              ? Icon(Icons.person, color: AppColors.primary, size: 55)
                              : null,
                        ),
                      ),
                      // Botón cámara visible y flotante
                      Positioned(
                        bottom: 2,
                        right: 2,
                        child: GestureDetector(
                          onTap: _pickImage,
                          child: Container(
                            decoration: BoxDecoration(
                              color: AppColors.primary, // Verde visible
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.white, width: 2),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black45,
                                  blurRadius: 4,
                                  spreadRadius: 1,
                                ),
                              ],
                            ),
                            padding: const EdgeInsets.all(6),
                            child: const Icon(
                              Icons.camera_alt,
                              color: Colors.black, // Contraste
                              size: 22,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 35),

            // Botones de acción destacados
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _quickAction(
                  icon: Icons.person_outline,
                  label: "Datos",
                  color: Colors.green,
                  onTap: () => Navigator.pushNamed(context, Routes.personal),
                ),
                _quickAction(
                  icon: Icons.location_on,
                  label: "Direcciones",
                  color: Colors.blueAccent,
                  onTap: () => Navigator.pushNamed(context, '/addresses'),
                ),
                _quickAction(
                  icon: Icons.credit_card,
                  label: "Pagos",
                  color: Colors.purpleAccent,
                  onTap: () => Navigator.pushNamed(context, '/payments'),
                ),
                _quickAction(
                  icon: Icons.history,
                  label: "Pedidos",
                  color: Colors.amber,
                  onTap: () => Navigator.pushNamed(context, '/orders'),
                ),
              ],
            ),

            const SizedBox(height: 32),

            // Soporte
            _sectionTitle('SOPORTE'),
            Card(
              margin: const EdgeInsets.symmetric(horizontal: 18, vertical: 6),
              color: AppColors.backgroundLight.withOpacity(0.9),
              elevation: 3,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
              child: Column(
                children: [
                  ListTile(
                    leading: const Icon(Icons.help_outline, color: Colors.white),
                    title: const Text('Centro de Ayuda', style: TextStyle(color: Colors.white, fontFamily: 'RobotoSlab')),
                    onTap: () => Navigator.pushNamed(context, Routes.help),
                  ),
                  ListTile(
                    leading: const Icon(Icons.description, color: Colors.white),
                    title: const Text('Términos y Condiciones', style: TextStyle(color: Colors.white, fontFamily: 'RobotoSlab')),
                    onTap: () => Navigator.pushNamed(context, Routes.terms),
                  ),
                  ListTile(
                    leading: const Icon(Icons.privacy_tip, color: Colors.white),
                    title: const Text('Política de Privacidad', style: TextStyle(color: Colors.white, fontFamily: 'RobotoSlab')),
                    onTap: () => Navigator.pushNamed(context, Routes.privacy),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Botón cerrar sesión centrado
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.danger,
                  minimumSize: const Size.fromHeight(48),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                icon: const Icon(Icons.logout, color: Colors.white),
                label: const Text('Cerrar Sesión', style: TextStyle(color: Colors.white, fontFamily: 'RobotoSlab', fontSize: 18)),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      backgroundColor: AppColors.backgroundLight,
                      title: const Text('Cerrar Sesión', style: TextStyle(color: Colors.white)),
                      content: const Text('¿Estás seguro de que quieres cerrar sesión?', style: TextStyle(color: Colors.white70)),
                      actions: [
                        TextButton(
                          child: const Text('Cancelar', style: TextStyle(color: Colors.white)),
                          onPressed: () => Navigator.pop(context),
                        ),
                        TextButton(
                          child: const Text('Cerrar Sesión', style: TextStyle(color: Colors.red)),
                          onPressed: () async {
                            // LIMPIA TODO Y REDIRIGE
                            final prefs = await SharedPreferences.getInstance();
                            await prefs.clear();
                            if (!mounted) return;
                            Navigator.pushNamedAndRemoveUntil(
                                context, Routes.home, (route) => false);
                          },
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 16),

            Center(
                child: Text('Versión de la aplicación: 1.0.0',
                    style: TextStyle(color: Colors.white38, fontSize: 13))),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }

  // Widget para stats/resumen
  Widget _statBox(IconData icon, String value, String label, {Color? color}) {
    return Column(
      children: [
        CircleAvatar(
          backgroundColor: color?.withOpacity(0.12) ?? Colors.white,
          radius: 22,
          child: Icon(icon, color: color ?? AppColors.primary, size: 26),
        ),
        const SizedBox(height: 6),
        Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white)),
        Text(label, style: const TextStyle(color: Colors.white54, fontSize: 12)),
      ],
    );
  }

  // Botón de acción rápido
  Widget _quickAction({required IconData icon, required String label, required Color color, required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        children: [
          CircleAvatar(
            backgroundColor: color.withOpacity(0.2),
            radius: 24,
            child: Icon(icon, color: color, size: 28),
          ),
          const SizedBox(height: 5),
          Text(label, style: const TextStyle(color: Colors.white, fontSize: 13, fontFamily: 'RobotoSlab'))
        ],
      ),
    );
  }

  Widget _sectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 24, top: 10, bottom: 5),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 15,
            color: Colors.green,
            fontFamily: 'RobotoSlab',
            fontWeight: FontWeight.bold),
      ),
    );
  }
}
