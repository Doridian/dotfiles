function ledfx
	CFLAGS="$CFLAGS -Wno-incompatible-pointer-types" CMAKE_POLICY_VERSION_MINIMUM=3.5 uv tool run ledfx
end

