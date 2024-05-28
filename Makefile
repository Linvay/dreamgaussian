gs2:
	python main2_gs.py --config configs/image2.yaml
	python main2.py --config configs/image.yaml

stage2:
	python main2.py --config configs/image.yaml

withgs2:
	python main.py --config configs/image.yaml
	python main2_gs.py --config configs/image2.yaml
	python main2.py --config configs/image.yaml

withoutgs2:
	python main.py --config configs/image.yaml
	python main2.py --config configs/image.yaml
