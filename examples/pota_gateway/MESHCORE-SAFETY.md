# MeshCore overlay — what must stay stock

Heltec V3 `Heltec_v3_room_server` only (`-D WITH_POTA_GATEWAY=1`).

| Area | Status |
|---|---|
| `src/` Dispatcher, BaseChatMesh, Mesh | Unmodified |
| `examples/simple_repeater` | Unmodified (repeater-v1.17.1) |
| Room BBS `storePost` cyclic queue, login, ACL, adverts | Stock; POTA parse after the post is stored |
| `loop()` | `the_mesh.loop()` first; `PotaSpotter::handleLoop()` last |
| Default repeat | Off (`disable_fwd = 1`) |
| Other room_server platforms | Do not compile `examples/pota_gateway` |

Do not put Wi-Fi or HTTP headers in `src/`. PlatformIO LDF would pull WiFiManager into every target.

Two live gateway rooms do not both decrypt one post. Encryption binds the post to one room identity.
