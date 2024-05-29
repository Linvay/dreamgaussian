IMG = ${img}
PROMPT = ${prompt}
COMMIT_MSG = ${m}

ifndef name
  ifdef img
    NAME = ${img}
  else
    NAME = test
  endif
else
  NAME = ${name}
endif

ifdef iters
  ITERS = ${iters}
else
  ITERS = 500
endif

ifdef gui
  GUI = ${gui}
else
  GUI = False
endif


stage1:
ifdef img 
	  python main.py --config configs/image.yaml input=data/${IMG}_rgba.png save_path=${NAME} iters=${ITERS} gui=${GUI}
else
	  python main.py --config configs/text.yaml prompt="${PROMPT}" save_path=${NAME} iters=${ITERS} gui=${GUI}
endif

stage2:
ifdef img 
	python main2.py --config configs/image.yaml input=data/${IMG}_rgba.png save_path=${NAME} mesh=logs/${IMG}_mesh.obj gui=${GUI}
else
	python main2.py --config configs/text.yaml prompt="${PROMPT}" save_path=${NAME} mesh=logs/${NAME}_mesh.obj gui=${GUI}
endif

gs2:
ifdef img 
	python main2_gs.py --config configs/image_gs2.yaml input=data/${IMG}_rgba.png save_path=${NAME} gui=${GUI}
else
	python main2_gs.py --config configs/text_gs2.yaml prompt="${PROMPT}" save_path=${NAME} gui=${GUI}
endif

stage2_gs2:
ifdef img
	python main2.py --config configs/image_gs2.yaml input=data/${IMG}_rgba.png save_path=${IMG} mesh=logs/${IMG}_mesh_2.obj gui=${GUI}
else 
	python main2.py --config configs/text_gs2.yaml prompt="${PROMPT}" save_path=${NAME} mesh=logs/${NAME}_mesh_2.obj gui=${GUI}
endif

withgs2:
ifdef img
	python main.py --config configs/image.yaml input=data/${IMG}_rgba.png save_path=${NAME} iters=${ITERS}
	python main2_gs.py --config configs/image.yaml input=data/${IMG}_rgba.png save_path=${NAME}
	python main2.py --config configs/image.yaml input=data/${IMG}_rgba.png save_path=${NAME} mesh=logs/${IMG}_mesh_2.obj
else
	python main.py --config configs/text.yaml prompt="${PROMPT}" save_path=${NAME} iters=${ITERS}
	python main2_gs.py --config configs/text_gs2.yaml prompt="${PROMPT}" save_path=${NAME}
	python main2.py --config configs/text_gs2.yaml prompt="${PROMPT}" save_path=${NAME} mesh=logs/${NAME}_mesh_2.obj
endif

cm:
	git add .
	git commit -m '${COMMIT_MSG}'

push:
	git push origin main

pull:
	git pull origin main