# Q2: Displaying Images

# Import and Setup
import matplotlib.pyplot as plt
import matplotlib.image as mpimg

images = ['img/IM-0001-0001.jpeg',
          'img/IM-0003-0001.jpeg',
          'img/IM-0005-0001.jpeg',
          'img/IM-0006-0001.jpeg']

"""
|
|   Modify the prodived script so that it displays four images
|
"""
fig = plt.figure(figsize=(2, 2))
for i, img in enumerate(images):
    fig.add_subplot(2, 2, i + 1)
    plt.imshow(mpimg.imread(img))

plt.show()
