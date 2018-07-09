FROM bebuch/gcc-qt:latest
MAINTAINER Benjamin Buch


# Install Eigen C++ library
RUN cd /opt \
	&& git clone https://github.com/eigenteam/eigen-git-mirror.git \
	&& cd eigen-git-mirror \
	&& git checkout branches/3.3 \
	&& mkdir build \
	&& cd build \
	&& cmake -DCMAKE_BUILD_TYPE=Release .. \
	&& make install \
	&& cd / \
	&& rm -r /opt/eigen-git-mirror


# Install FLANN
RUN cd /opt \
	&& git clone https://github.com/mariusmuja/flann.git \
	&& cd flann \
	&& git checkout tags/1.9.1 \
	&& mkdir build \
	&& cd build \
	&& cmake -DCMAKE_BUILD_TYPE=Release .. \
	&& make -j2 \
	&& make install \
	&& cd / \
	&& rm -r /opt/flann


# Install VTK
RUN cd /opt \
	&& wget "https://www.vtk.org/files/release/8.1/VTK-8.1.1.tar.gz" \
	&& tar xvf VTK-8.1.1.tar.gz \
	&& rm VTK-8.1.1.tar.gz \
	&& cd VTK-8.1.1 \
	&& mkdir build \
	&& cd build \
	&& cmake -DCMAKE_BUILD_TYPE=Release -DVTK_Group_Qt:BOOL=ON .. \
	&& make -j2 \
	&& make install \
	&& cd / \
	&& rm -r /opt/VTK-8.1.1


# Install PCL
RUN cd /opt \
	&& git clone https://github.com/PointCloudLibrary/pcl.git \
	&& cd /opt/pcl \
	&& mkdir build \
	&& cd build \
	&& cmake -DCMAKE_BUILD_TYPE=Release .. \
	&& make -j2 \
	&& make install \
	&& make clean \
	&& cd / \
	&& rm -r /opt/pcl

# Set library path
ENV LD_LIBRARY_PATH=/usr/local/lib:/usr/local/Qt-5.11.1/lib/
