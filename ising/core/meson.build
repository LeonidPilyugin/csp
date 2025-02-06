sources = files(
  'disturbance.vala',
  'energy.vala',
  'integrator.vala',
  'system.vala'
)

core_build_dir = meson.current_build_dir()

core_lib_target = custom_target(
  'corelib',
  command: [
    valac,
    [
      '--disable-warnings',
      '-X', '-fPIC',
      '-X', '-shared',
      '-X', '-w',
      '-X', '-O3',
      '-X', '-lm',
      '-X', '-o' + core_build_dir / 'libcore-1.0.so',
      '--pkg=glib-2.0',
      '--pkg=gobject-2.0',
      '--directory=' + core_build_dir,
      '-H', core_build_dir / 'Core-1.0.h',
      '--gir=' + 'Core-1.0.gir',
      '--library=' + 'Core-1.0',
      '--output=libcore-1.0.so',
    ],
    sources
  ],
  output: 'libcore-1.0.so',
  build_by_default: true,
)

core_typelib_target = custom_target(
  'coretypelib',
  command: [
    g_ir_compiler,
    '--includedir=' + core_build_dir,
    '--output=' + core_build_dir / 'Core-1.0.typelib',
    '--shared-library',
    core_lib_target.full_path(),
    core_build_dir / 'Core-1.0.gir',
  ],
  depends: core_lib_target,
  output: 'Core-1.0.typelib',
  build_by_default: true,
)
