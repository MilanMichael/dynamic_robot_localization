#!/usr/bin/env bash

echo "####################################################################################################"
echo "##### Cloning git repositories"
echo "####################################################################################################"

catkin_ws=${1:-"$HOME/catkin_ws"}
repositories=${2:-"dynamic_robot_localization pose_to_tf_publisher laserscan_to_pointcloud octomap_mapping mesh_to_pointcloud"}

cd "${catkin_ws}/src"
if [ $? -ne 0 ]; then
	mkdir -p "${catkin_ws}/src"
	cd "${catkin_ws}/src"
	catkin_init_workspace
fi

wstool init
for git_repository in ${repositories}
do
	ls "${git_repository}" &> /dev/null
	if [ $? -ne 0 ]; then
		echo -e "\n\n"
		echo "-------------------------------------------"
		echo "==> Cloning ${git_repository}"
		git clone "https://github.com/carlosmccosta/${git_repository}.git"
		wstool set ${git_repository} "https://github.com/carlosmccosta/${git_repository}.git" --git -y
	else
		echo -e "\n\n"
		echo "-------------------------------------------"
		echo "==> Updating ${git_repository}"
		cd ${git_repository}
		git pull
		cd ..
	fi
done


echo -e "\n\n"
echo "----------------------------------------------------------------------------------------------------"
echo ">>>>> Cloning git repositories finished"
echo ">>>>> For updating each git repository use: git pull"
echo ">>>>> For updating all repositories use:"
echo ">>>>> ${catkin_ws}/src/dynamic_robot_localization/install/c_repositories_update.sh"
echo ">>>>> or"
echo ">>>>> cd ${catkin_ws}/src"
echo ">>>>> wstool status"
echo ">>>>> Commit or stash modified files"
echo ">>>>> wstool update"
echo "----------------------------------------------------------------------------------------------------"
