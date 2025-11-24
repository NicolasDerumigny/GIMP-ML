import torch
import torch.nn as nn
import math
import sys

class dehaze_net(nn.Module):
    def __init__(self):
        super(dehaze_net, self).__init__()

        self.relu = nn.ReLU(inplace=True)

        self.e_conv1 = nn.Conv2d(3, 3, 1, 1, 0, bias=True)
        self.e_conv2 = nn.Conv2d(3, 3, 3, 1, 1, bias=True)
        self.e_conv3 = nn.Conv2d(6, 3, 5, 1, 2, bias=True)
        self.e_conv4 = nn.Conv2d(6, 3, 7, 1, 3, bias=True)
        self.e_conv5 = nn.Conv2d(12, 3, 3, 1, 1, bias=True)

    def forward(self, x):
        source = []
        source.append(x)

        x1 = self.relu(self.e_conv1(x))
        print(0.10)
        sys.stdout.flush()

        x2 = self.relu(self.e_conv2(x1))
        print(0.20)
        sys.stdout.flush()

        concat1 = torch.cat((x1, x2), 1)
        print(0.30)
        sys.stdout.flush()

        x3 = self.relu(self.e_conv3(concat1))
        print(0.40)
        sys.stdout.flush()

        concat2 = torch.cat((x2, x3), 1)
        x4 = self.relu(self.e_conv4(concat2))
        print(0.50)
        sys.stdout.flush()

        concat3 = torch.cat((x1, x2, x3, x4), 1)
        x5 = self.relu(self.e_conv5(concat3))
        print(0.60)
        sys.stdout.flush()

        clean_image = self.relu((x5 * x) - x5 + 1)
        print(0.90)
        sys.stdout.flush()

        return clean_image
