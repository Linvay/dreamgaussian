IMG = ${img}
COMMIT_MSG = ${m}

ifdef iters
  ITERS = ${iters}
else
  ITERS = 500
endif

stage1:
	python main.py --config configs/image.yaml input=data/${IMG}_rgba.png save_path=${IMG} iters=${ITERS}

stage2:
	python main2.py --config configs/image.yaml input=data/${IMG}_rgba.png save_path=${IMG} mesh=logs/${IMG}_mesh.obj

gs2:
	python main2_gs.py --config configs/image_gs2.yaml input=data/${IMG}_rgba.png save_path=${IMG}

stage2_gs2:
	python main2.py --config configs/image.yaml input=data/${IMG}_rgba.png save_path=${IMG} mesh=logs/${IMG}_mesh_2.obj

withgs2:
	python main.py --config configs/image.yaml input=data/${IMG}_rgba.png save_path=${IMG} iters=${ITERS}
	python main2_gs.py --config configs/image_gs2.yaml input=data/${IMG}_rgba.png save_path=${IMG}
	python main2.py --config configs/image_gs2.yaml input=data/${IMG}_rgba.png save_path=${IMG} mesh=logs/${IMG}_mesh_2.obj

cm:
	git add .
	git commit -m '${COMMIT_MSG}'

push:
	git push origin main

pull:
	git pull origin main