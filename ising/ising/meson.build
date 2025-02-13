sources = files(
  'disturbance.vala',
  'energy.vala',
  'energy6.vala',
  'system.vala'
)

ising_build_dir = meson.current_build_dir()

ising_lib_target = custom_target(
  'isinglib',
  command: [
    valac,
    [
      '--disable-warnings',
      '-X', '-fPIC',
      '-X', '-shared',
      '-X', '-w',
      '-X', '-O3',
      '-X', '-lm',
      '-X', '-o' + ising_build_dir / 'libising-1.0.so',
      '-X', '-I' + core_build_dir,
      '-X', '-L' + core_build_dir,
      '-X', '-l' + 'core-1.0',
      '--girdir=' + core_build_dir,
      '--vapidir=' + core_build_dir,
      '--pkg=glib-2.0',
      '--pkg=gobject-2.0',
      '--pkg=Core-1.0',
      '--directory=' + ising_build_dir,
      '-H', ising_build_dir / 'Ising-1.0.h',
      '--gir=' + 'Ising-1.0.gir',
      '--library=' + 'Ising-1.0',
      '--output=libising-1.0.so',
    ],
    sources
  ],
  depends: core_lib_target,
  output: 'libising-1.0.so',
  build_by_default: true,
)

ising_typelib_target = custom_target(
  'isingtypelib',
  command: [
    g_ir_compiler,
    '--includedir=' + ising_build_dir,
    '--includedir=' + core_build_dir,
    '--output=' + ising_build_dir / 'Ising-1.0.typelib',
    '--shared-library',
    ising_lib_target.full_path(),
    ising_build_dir / 'Ising-1.0.gir',
  ],
  depends: ising_lib_target,
  output: 'Ising-1.0.typelib',
  build_by_default: true,
)
